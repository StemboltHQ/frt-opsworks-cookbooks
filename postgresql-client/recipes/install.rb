# Remove previous Postgres client
package 'postgresql' do
  action :remove
end

# Install Postgres 11 Client
remote_file "#{Chef::Config[:file_cache_path]}/postgresql11-libs.rpm" do
  source "https://jiffy-linux-packages.s3.amazonaws.com/postgresql11-libs-11.9-1PGDG.rhel6.x86_64.rpm"
  action :create
end

rpm_package "postgresql11-libs-custom" do
  source "#{Chef::Config[:file_cache_path]}/postgresql11-libs.rpm"
  action :install
end

remote_file "#{Chef::Config[:file_cache_path]}/postgresql11.rpm" do
  source "https://jiffy-linux-packages.s3.amazonaws.com/postgresql11-11.9-1PGDG.rhel6.x86_64.rpm"
  action :create
end

rpm_package "postgresql11-custom" do
  source "#{Chef::Config[:file_cache_path]}/postgresql11.rpm"
  action :install
end

remote_file "#{Chef::Config[:file_cache_path]}/postgresql11-devel.rpm" do
  source "https://jiffy-linux-packages.s3.amazonaws.com/postgresql11-devel-11.9-1PGDG.rhel6.x86_64.rpm"
  action :create
end

rpm_package "postgresql11-custom" do
  source "#{Chef::Config[:file_cache_path]}/postgresql11-devel.rpm"
  action :install
end
