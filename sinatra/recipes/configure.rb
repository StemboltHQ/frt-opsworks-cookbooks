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

  # Steal the database.yml template from the opsworks rails cookbook
  template "#{deploy[:deploy_to]}/shared/config/database.yml" do
    source "database.yml.erb"
    cookbook "rails"
    mode "0660"
    group deploy[:group]
    owner deploy[:user]
    variables(database: deploy[:database], environment: deploy[:rack_env])

    notifies :run, "execute[restart Sinatra application #{application}]"

    only_if do
      deploy[:database][:host].present? && File.directory?("#{deploy[:deploy_to]}/shared/config/")
    end
  end
end
