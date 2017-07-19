include_recipe 'logrotate::global'
include_recipe 'logrotate::default'

node.set['logrotate']['global']['/var/log/wtmp'] = {
  'monthly' => true,
  'create'  => '0664 root utmp',
  'rotate'  => 1,
  'minsize' => '1M'
}

node.set['logrotate']['global']['/var/log/btmp'] = {
  'missingok' => true,
  'monthly'   => true,
  'create'    => '0600 root utmp',
  'rotate'    => 1
}

logrotate_app 'dracut' do
  path      '/var/log/dracut.log'
  options   ['missingok', 'notifempty']
  frequency 'yearly'
  size      '30k'
  create    '0600 root root'
end

logrotate_app 'monit' do
  path       '/var/log/monit'
  options    ['missingok', 'notifempty']
  size       '100k'
  create     '0644 root root'
  postrotate ['/usr/bin/pkill -HUP -U root -x monit > /dev/null 2>&1 || :']
end

logrotate_app 'nginx' do
  path       '/var/log/nginx/*log'
  options    ['missingok', 'notifempty', 'compress', 'sharedscripts']
  frequency  'daily'
  rotate     10
  create     '0644 nginx nginx'
  postrotate ['/etc/init.d/nginx reopen_logs']
end

logrotate_app 'psacct' do
  path      '/var/account/pacct'
  options   ['compress', 'delaycompress', 'notifempty']
  frequency 'daily'
  rotate     31
  create     '0600 root root'
  postrotate ['/usr/sbin/accton /var/account/pacct']
end

logrotate_app 'syslog' do
  path        [
                '/var/log/cron',
                '/var/log/maillog',
                '/var/log/messages',
                '/var/log/secure',
                '/var/log/spooler'
              ]
  options     ['sharedscripts']
  postrotate  ['/bin/kill -HUP `cat /var/run/syslogd.pid 2> /dev/null` 2> /dev/null || true']
end

logrotate_app 'yum' do
  path      '/var/log/yum.log'
  options   ['missingok', 'notifempty']
  frequency 'yearly'
  size      '30k'
  create    '0600 root root'
end

# Rails apps
node['logrotate']['rails_apps'].each do |app_name, app_data|
  logrotate_app app_name do
    path       app_data['log_path']
    options    ['missingok', 'compress', 'delaycompress', 'notifempty', 'copytruncate', 'sharedscripts']
    frequency  'daily'
    rotate     30
    postrotate <<-EOF
      export AWS_ACCESS_KEY_ID=#{node['logrotate']['aws_access_key']}
      export AWS_SECRET_ACCESS_KEY=#{node['logrotate']['aws_secret_key']}

      /usr/bin/aws s3 cp #{app_data['log_dir']} s3://#{node['logrotate']['s3_bucket']}/'$HOMENAME'/#{app_data['s3_dir']}/ --region #{node['logrotate']['s3_region']} #{app_data['options']}
    EOF
  end
end
