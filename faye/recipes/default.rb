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

  bash "faye-start-#{application}" do
    user deploy[:user]
    cwd "#{deploy[:deploy_to]}/current"

    # thin will error if faye is already running
    ignore_failure true

    # Faye runs in production. even not in production
    code "bundle exec thin start -d -l log/faye.log -P tmp/pids/faye.pid -R faye.ru -e production --tag faye"
  end
end

