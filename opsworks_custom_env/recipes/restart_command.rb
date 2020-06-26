node[:deploy].each do |application, deploy|
  if deploy[:application_type] != 'rails'
    Chef::Log.debug("Skipping opsworks_custom_env::restart_command for application #{application} as it is not a rails app")
    next
  end

  execute "restart Rails app #{application} for custom env" do
    cwd deploy[:current_path]
    command node[:opsworks][:rails_stack][:restart_command]

    action :nothing
  end

end
