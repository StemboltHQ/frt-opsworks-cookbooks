#
# Cookbook Name:: delayed_job
# Recipe:: restart
#
# Copyright 2013, FreeRunning Technologies
#
# All rights reserved - Do Not Redistribute
#

node[:deploy].each do |application, deploy|
  deploy = node[:deploy][application]

  bash 'delayed-job-restart' do
    user 'root'
    code "monit restart #{application}_delayed_job"
    only_if "sudo monit summary | grep #{application}_delayed_job"
  end
end

