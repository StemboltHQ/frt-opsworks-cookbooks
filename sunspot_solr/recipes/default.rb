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
      :data_dir => node[:solr][:data_dir]
    )
  end
end

bash 'monit-reload' do
  user 'root'
  code 'monit reload'
end
