# Remove previous Postgres client
package 'postgresql' do
  action :remove
end

# Install Postgres 11 Client
remote_file "#{Chef::Config[:file_cache_path]}/postgresql12-libs.rpm" do
  source "https://jiffy-linux-packages.s3.amazonaws.com/postgresql12-libs-12.5-1PGDG.rhel6.x86_64.rpm"
  retries 3
end

rpm_package "postgresql12-libs" do
  source "#{Chef::Config[:file_cache_path]}/postgresql12-libs.rpm"
end

remote_file "#{Chef::Config[:file_cache_path]}/postgresql12.rpm" do
  source "https://jiffy-linux-packages.s3.amazonaws.com/postgresql12-12.5-1PGDG.rhel6.x86_64.rpm"
  retries 3
end

rpm_package "postgresql12" do
  source "#{Chef::Config[:file_cache_path]}/postgresql12.rpm"
end

remote_file "#{Chef::Config[:file_cache_path]}/postgresql12-devel.rpm" do
  source "https://jiffy-linux-packages.s3.amazonaws.com/postgresql12-devel-12.5-1PGDG.rhel6.x86_64.rpm"
  retries 3
end

rpm_package "postgresql12-devel" do
  source "#{Chef::Config[:file_cache_path]}/postgresql12-devel.rpm"
end
