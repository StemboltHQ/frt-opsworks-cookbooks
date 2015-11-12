#
# Cookbook Name:: sinatra
# Recipe:: deploy
#
# Copyright 2015, Stembolt
#
# All rights reserved - Do Not Redistribute
#

node[:deploy].each do |application, _|
  deploy = node[:deploy][application]

  if deploy[:application_type] != 'rack'
    Chef::Log.debug("Skipping application #{application} as it is not of type 'rack'")
    next
  end

  opsworks_deploy_dir do
    user deploy[:user]
    group deploy[:group]
    path deploy[:deploy_to]
  end

  nginx_web_app application do
    cookbook "unicorn"
    docroot deploy[:absolute_document_root]
    server_name deploy[:domains]
    server_aliases []
    rails_env deploy[:rack_env]
    mounted_at deploy[:mounted_at]
    ssl_certificate_ca deploy[:ssl_certificate_ca]
    deploy deploy
    template "nginx_unicorn_web_app.erb"
    application deploy
  end

  opsworks_deploy do
    deploy_data deploy
    app application
  end

  execute "ln -s #{deploy[:deploy_to]}/shared/config/database.yml #{deploy[:deploy_to]}/current/config/database.yml" do
    only_if do
      File.exist? "#{deploy[:deploy_to]}/shared/config/database.yml"
    end
  end

  execute "bundle exec rake db:migrate" do
    cwd deploy[:deploy_to] + "/current"
    only_if do
      deploy[:database].present?
    end
  end

  execute "bundle install" do
    cwd deploy[:deploy_to] + "/current"
  end
end
