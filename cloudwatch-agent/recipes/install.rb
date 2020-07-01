remote_file '/opt/amazon-cloudwatch-agent.rpm' do
  source 'https://s3.amazonaws.com/amazoncloudwatch-agent/amazon_linux/amd64/latest/amazon-cloudwatch-agent.rpm'
end

rpm_package 'amazon-cloudwatch-agent.rpm' do
  source '/opt/amazon-cloudwatch-agent.rpm'
  action :install
end

cookbook_file '/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent-statsd.json' do
  source 'amazon-cloudwatch-agent.json'
end

bash 'run agent' do
  code 'amazon-cloudwatch-agent-ctl -a start -m ec2'
end

bash 'configure agent' do
  code "amazon-cloudwatch-agent-ctl -a fetch-config -s -c file:/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent-statsd.json"
end
