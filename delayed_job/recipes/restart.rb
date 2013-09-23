#
# Cookbook Name:: delayed_job
# Recipe:: restart
#
# Copyright 2013, FreeRunning Technologies
#
# All rights reserved - Do Not Redistribute
#

bash 'delayed-job-restart' do
  user 'root'
  code 'monit restart delayed_job'
end

