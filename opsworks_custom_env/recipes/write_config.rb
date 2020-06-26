# Set up app's custom configuration in the environment.
# See https://forums.aws.amazon.com/thread.jspa?threadID=118107

node[:deploy].each do |application, deploy|
  if deploy[:application_type] != 'rails'
    Chef::Log.debug("Skipping opsworks_custom_env::restart_command for application #{application} as it is not a rails app")
    next
  end
  
  custom_env_template do
    application application
    deploy deploy
    env node[:custom_env][application]
  end
  
end
