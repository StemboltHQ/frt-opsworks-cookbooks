%w[ daily monthly yearly ].each do |freq|
  node.override['logrotate']['global'][freq] = false
end

node.override['logrotate']['global']['weekly'] = true

node.default['logrotate']['global']['rotate'] = 4

node.default['logrotate']['global']['create'] = true

node.default['logrotate']['global']['dateext'] = true
