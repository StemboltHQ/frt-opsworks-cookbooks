
include_recipe 'deploy'

node[:deploy].each do |application, deploy|
  deploy = node[:deploy][application]

  global = node[:delayed_job] || {}

  if deploy[:delayed_job].is_a?(Array)
    index = 0
    workers = []
    deploy[:delayed_job].each do |dj|
      worker_count = dj[:worker_count] || 1
      worker_count.times do
        index += 1
        identifier = dj[:identifier] || index
        workers << {
          :timeout => dj[:timeout] || global[:timeout],
          :bin => dj[:bin] || global[:bin],
          :identifier => identifier,
          :suffix => ".#{index}",
          :options => dj[:options] || global[:options]
        }
      end
    end
  else
    # For backwards compatability with existing json
    # :delayed_job => true
    workers = [global]
  end

  template "/etc/monit.d/#{application}_delayed_job.monitrc" do
    source 'delayed_job.monitrc.erb'
    owner 'root'
    group 'root'
    mode '0755'
    variables(
      :app => application,
      :env => deploy[:rails_env],
      :dir => deploy[:deploy_to],
      :user => deploy[:user],
      :group => deploy[:group],
      :workers => workers
    )
    only_if { deploy[:delayed_job] }
  end
end
