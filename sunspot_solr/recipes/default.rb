#
# Cookbook Name:: sunspot_solr
# Recipe:: default
#
# Copyright 2013, FreeRunning Technologies
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'deploy'

node[:deploy].each do |application, deploy|
  deploy = node[:deploy][application]
  data_dir = "/mnt/#{application}_solr"

  directory data_dir do
    user deploy[:user]
    group deploy[:group]
    action :create
    mode "0755"
  end

  template "/etc/monit.d/#{application}_sunspot_solr.monitrc" do
    source 'sunspot_solr.monitrc.erb'
    owner 'root'
    group 'root'
    mode '0755'
    variables(
      :app => application,
      :env => deploy[:rails_env],
      :dir => deploy[:deploy_to],
      :user => deploy[:user],
      :group => deploy[:group],
      :timeout => 30,
      :data_dir => data_dir
    )
  end
end

bash 'monit-reload' do
  user 'root'
  code 'monit reload'
end
