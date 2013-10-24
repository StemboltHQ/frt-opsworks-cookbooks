#
# Cookbook Name:: faye
# Recipe:: default
#
# Copyright 2013, FreeRunning Technologies
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'deploy'

node[:deploy].each do |application, deploy|
  deploy = node[:deploy][application]

  template "#{deploy[:deploy_to]}/shared/scripts/faye" do
    mode '0755'
    owner deploy[:user]
    group deploy[:group]
    source "faye.service.erb"
    variables(:deploy => deploy, :application => application)
  end

  bash "faye-restart-#{application}" do
    user deploy[:user]
    code "#{deploy[:deploy_to]}/shared/scripts/faye restart"
  end
end

