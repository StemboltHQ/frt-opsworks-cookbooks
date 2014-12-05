package "monit"

include_recipe "opsworks_agent_monit::service"

template node[:monit][:conf] do
  source "monitrc.erb"
  mode 0600
  notifies :restart, resources(:service => "monit")
end
