#
# Cookbook Name:: sinatra
# Recipe:: configure
#
# Copyright 2015, Stembolt
#
# All rights reserved - Do Not Redistribute
#

node[:deploy].each do |application, _|
  deploy = node[:deploy][application]

  execute "restart Sinatra application #{application}" do
    cwd deploy[:current_path]
    command node[:opsworks][:rails_stack][:restart_command]
    action :nothing
  end

end
