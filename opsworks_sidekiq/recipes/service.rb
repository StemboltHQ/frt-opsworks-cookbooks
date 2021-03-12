service "monit" do
  supports :status => false, :restart => true, :reload => true
  action :nothing
end


node[:deploy].each do |application, deploy|

  unless node[:sidekiq][application]
    next
  end

  # Overwrite the unicorn restart command declared elsewhere
  # Apologies for the `sleep`, but monit errors with "Other action already in progress" on some boots.
  execute "restart Sidekiq app #{application}" do
    command "sleep 150 && #{node[:sidekiq][application][:restart_command]}"
    action :nothing
  end

end
