include_recipe "awslogs::service"

template "/var/awslogs/etc/awslogs.conf" do
  source "awslogs.conf.erb"
  owner "root"
  group "root"
  mode 0644

  notifies :restart, "service[awslogs]"
end

