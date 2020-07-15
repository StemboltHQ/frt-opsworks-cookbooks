cookbook_file '/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent-statsd.json' do
  source 'amazon-cloudwatch-agent.json'
end

bash 'configure agent' do
  code "amazon-cloudwatch-agent-ctl -a fetch-config -s -c file:/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent-statsd.json"
end
