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
      :timeout => node[:delayed_job][:timeout]
    )
    only_if "cd #{deploy[:deploy_to]}/current && bundle show delayed_job"
  end
end

bash 'monit-reload' do
  user 'root'
  code 'monit reload'
end
