template '/srv/www/jiffyshirts/current/public/maintenance.html' do
  source 'maintenance.html.erb'
  owner 'deploy'
  variables(estimated_end_time: node[:maintenance][:estimated_end_time])
end

file '/srv/www/jiffyshirts/current/public/offline' do
  user 'deploy'
  action :touch
end
