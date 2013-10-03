#
# Cookbook Name:: delayed_job
# Recipe:: restart
#
# Copyright 2013, FreeRunning Technologies
#
# All rights reserved - Do Not Redistribute
#

node[:deploy].each do |application, deploy|
  bash 'delayed-job-restart' do
    user 'root'
    code "monit restart #{application}_delayed_job"
  end
end

