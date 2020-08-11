# Set up app's redshift configuration in the environment.

node[:deploy].each do |application, deploy|
  redshift_config_template do
    application application
    deploy deploy
    env node[:deploy][application][:redshift_database]
  end
end
