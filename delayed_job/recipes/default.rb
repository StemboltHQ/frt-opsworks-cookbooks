#
# Cookbook Name:: delayed_job
# Recipe:: default
#
# Copyright 2013, FreeRunning Technologies
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'delayed_job::template'

bash 'monit-reload' do
  user 'root'
  code 'monit reload'
end
