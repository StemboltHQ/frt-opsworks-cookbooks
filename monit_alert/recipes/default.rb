#
# Cookbook Name:: monit_alert
# Recipe:: default
#

template "/etc/monit.d/alert.monitrc" do
  source 'alert.monitrc.erb'
  owner 'root'
  group 'root'
  mode '0644'
  variables(
    email: node[:monit_alert][:email],
    smtp_server: node[:monit_alert][:smtp][:server],
    smtp_username: node[:monit_alert][:smtp][:username],
    smtp_password: node[:monit_alert][:smtp][:password],
    smtp_hostname: node[:monit_alert][:smtp][:hostname],
  )
end

bash 'monit-reload' do
  user 'root'
  code 'monit reload'
end
