unless node.recipes.include?('deploy::rails')
  include_recipe 'deploy::rails'

  node[:deploy].each do |application, deploy|
    r = resources(template: "#{deploy[:deploy_to]}/shared/scripts/unicorn")
    r.source('unicorn.service.disabled.erb')
  end
end
