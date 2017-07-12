%w[ daily monthly yearly ].each do |freq|
  node.override['logrotate']['global'][freq] = false
end

node.override['logrotate']['global']['weekly'] = true

node['logrotate']['global']['rotate'] = 4

node['logrotate']['global']['create'] = true

node['logrotate']['global']['dateext'] = true

node['logrotate']['global']['include'] = '/etc/logrotate.d'
