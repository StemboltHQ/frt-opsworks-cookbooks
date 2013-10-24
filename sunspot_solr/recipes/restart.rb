#
# Cookbook Name:: sunspot_solr
# Recipe:: restart
#
# Copyright 2013, FreeRunning Technologies
#
# All rights reserved - Do Not Redistribute
#

node[:deploy].each do |application, deploy|
  deploy = node[:deploy][application]

  bash "sunspot_solr-restart-#{application}" do
    user 'root'
    code "monit restart #{application}_sunspot_solr"
  end
end

