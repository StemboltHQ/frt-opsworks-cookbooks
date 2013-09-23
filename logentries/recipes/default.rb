#
# Cookbook Name:: logentries
# Recipe:: default
#
# Copyright 2013, FreeRunning Technologies
#
# All rights reserved - Do Not Redistribute
#

cookbook_file '/etc/ssl/certs/logentries.all.crt' do
  source 'logentries.all.crt'
  owner 'root'
  group 'root'
  mode '0755'
end

template '/etc/rsyslog.d/logentries.conf' do
  source 'logentries.conf.erb'
  owner 'root'
  group 'root'
  mode '0755'
  variables(
    :token => node[:deploy][:hats][:logentries][:token]
  )
end

bash 'install-rsyslog-gnutls' do
  user 'root'
  code 'yum -y install rsyslog-gnutls'
end

bash 'rsyslog-restart' do
  user 'root'
  code 'service rsyslog restart'
end
