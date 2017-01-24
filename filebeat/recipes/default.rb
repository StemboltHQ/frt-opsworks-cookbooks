yum_repository 'filebeat' do
  description 'Elastic repository for 5.x packages'
  baseurl 'https://artifacts.elastic.co/packages/5.x/yum'
  gpgkey 'https://artifacts.elastic.co/GPG-KEY-elasticsearch'
end

yum_package 'filebeat'

template '/etc/filebeat/filebeat.yml' do
  source 'filebeat.yml.erb'
  owner 'root'
  group 'root'
  mode '0644'
  variables(
    paths: node[:filebeat][:paths],
    hosts: node[:filebeat][:hosts],
    protocol: node[:filebeat][:protocol],
    username: node[:filebeat][:username],
    password: node[:filebeat][:password]
  )
end

service 'filebeat' do
  action :start
end
