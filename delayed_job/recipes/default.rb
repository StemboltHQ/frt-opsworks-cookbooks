#
# Cookbook Name:: delayed_job
# Recipe:: default
#
# Copyright 2013, FreeRunning Technologies
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'deploy'

node[:deploy].each do |application, deploy|
  deploy = node[:deploy][application]

  global = node[:delayed_job] || {}

  if deploy[:delayed_job].is_a?(Array)
    index = 0
    workers = deploy[:delayed_job].map do |dj|
      index += 1
      identifier = dj[:identifier] || index
      {
        :timeout => dj[:timeout] || global[:timeout],
        :bin => dj[:bin] || global[:bin],
        :identifier => identifier,
        :suffix => ".#{identifier}",
        :options => dj[:options] || global[:options]
      }
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

bash 'monit-reload' do
  user 'root'
  code 'monit reload'
end
