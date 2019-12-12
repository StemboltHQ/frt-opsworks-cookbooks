# Remove previous Postgres client
package 'postgresql' do
  action :remove
end

# Install Postgres 10 Client
remote_file "#{Chef::Config[:file_cache_path]}/postgresql10-libs.rpm" do
  source "https://jiffy-linux-packages.s3.amazonaws.com/postgresql10-libs-10.10-1PGDG.rhel6.x86_64.rpm"
  action :create
end

rpm_package "postgresql10-libs-custom" do
  source "#{Chef::Config[:file_cache_path]}/postgresql10-libs.rpm"
  action :install
end

remote_file "#{Chef::Config[:file_cache_path]}/postgresql10.rpm" do
  source "https://jiffy-linux-packages.s3.amazonaws.com/postgresql10-10.10-1PGDG.rhel6.x86_64.rpm"
  action :create
end

rpm_package "postgresql10-custom" do
  source "#{Chef::Config[:file_cache_path]}/postgresql10.rpm"
  action :install
end

remote_file "#{Chef::Config[:file_cache_path]}/postgresql10-devel.rpm" do
  source "https://jiffy-linux-packages.s3.amazonaws.com/postgresql10-devel-10.10-1PGDG.rhel6.x86_64.rpm"
  action :create
end

rpm_package "postgresql10-custom" do
  source "#{Chef::Config[:file_cache_path]}/postgresql10-devel.rpm"
  action :install
end

yum_package 'postgresql10' do
  action :install
end

yum_package 'postgresql10-devel' do
  action :install
end
