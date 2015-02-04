directory "/opt/aws/cloudwatch" do
  recursive true
end

remote_file "/opt/aws/cloudwatch/awslogs-agent-setup.py" do
  source "https://s3.amazonaws.com/aws-cloudwatch/downloads/latest/awslogs-agent-setup.py"
  mode "0755"
end

template "/tmp/awslogs.conf" do
  source "awslogs.conf.erb"
  owner "root"
  group "root"
  mode 0644
end

execute "Install CloudWatch Logs agent" do
  command "/opt/aws/cloudwatch/awslogs-agent-setup.py -n -r #{node[:opsworks][:instance][:region]} -c /tmp/awslogs.conf"
  not_if { system "pgrep -f aws-logs-agent-setup" }
end
