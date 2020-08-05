# Accepts:
#   application (application name)
#   deploy (hash of deploy attributes)
#   env (hash of database configuration)
#
# Notifies a "restart Rails app <name> for redshift configuration" resource.

define :redshift_config_template do
  template "#{params[:deploy][:deploy_to]}/shared/config/redshift.database.yml" do
    cookbook 'redshift_config'
    source "redshift.database.yml.erb"
    owner params[:deploy][:user]
    group params[:deploy][:group]
    mode "0660"
    variables :env => params[:env], :environment => params[:deploy][:rails_env]

    only_if do
      File.exists?("#{params[:deploy][:deploy_to]}/shared/config")
    end
  end

end
