# Adapted from unicorn::rails: https://github.com/aws/opsworks-cookbooks/blob/master/unicorn/recipes/rails.rb

include_recipe "opsworks_sidekiq::service"

def deep_transform_values(values)
  case values
  when Chef::Node::ImmutableArray
    values.to_a.map { |value| deep_transform_values(value) }
  when Chef::Node::ImmutableMash
    # No further transformation since we have no nested hash configurations
    values.to_hash
  else
    values
  end
end

# setup sidekiq service per app
node[:deploy].each do |application, deploy|

  unless node[:sidekiq][application]
    next
  end

  case node['platform_family']
  when 'rhel', 'fedora'
    monit_conf_dir = '/etc/monit.d'
  when 'debian'
    monit_conf_dir = '/etc/monit/conf.d'
  end

  if deploy[:application_type] != 'rails'
    Chef::Log.debug("Skipping opsworks_sidekiq::setup application #{application} as it is not a Rails app")
    next
  end

  opsworks_deploy_user do
    deploy_data deploy
  end

  opsworks_deploy_dir do
    user deploy[:user]
    group deploy[:group]
    path deploy[:deploy_to]
  end

  directory "#{deploy[:deploy_to]}/shared/assets" do
    group deploy[:group]
    owner deploy[:user]
    mode 0775
    action :create
    recursive true
  end

  # Allow deploy user to restart workers
  template "/etc/sudoers.d/#{deploy[:user]}" do
    mode 0440
    source "sudoer.erb"
    variables :user => deploy[:user]
  end

  if node[:sidekiq][application]

    workers = node[:sidekiq][application].to_hash.reject {|k,v| k.to_s =~ /restart_command|syslog/ }
    config_directory = "#{deploy[:deploy_to]}/shared/config"

    workers.each do |worker, options|
      # Convert attribute classes to plain old ruby objects
      config = options[:config] ? options[:config].to_hash : {}
      config.each do |k, v|
        config[k] = deep_transform_values(v)
      end

      # Generate YAML string
      yaml = YAML::dump(config)

      # Convert YAML string keys to symbol keys for sidekiq while preserving
      # indentation. (queues: to :queues:)
      yaml = yaml.gsub(/^(\s*)([^:][^\s]*):/,'\1:\2:')

      file "#{config_directory}/sidekiq_#{worker}.yml" do
        mode 0644
        action :create
        content yaml
      end
    end

    template "#{monit_conf_dir}/sidekiq_#{application}.monitrc" do
      mode 0644
      source "sidekiq_monitrc.erb"
      opts = {
        :syslog_ident => node[:sidekiq][application][:syslog_ident],
        :syslog => node[:sidekiq][application][:syslog]
      }
      variables({
        :deploy => deploy,
        :application => application,
        :workers => workers,
        :opts => opts
      })
      notifies :reload, resources(:service => "monit"), :immediately
    end

  end
end
