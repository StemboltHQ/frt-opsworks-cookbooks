case node['opsworks']['ruby_version']
when '2.3'
  normal[:ruby][:major_version] = '2'
  normal[:ruby][:minor_version] = '3'
  normal[:ruby][:patch_version] = '7'
  normal[:ruby][:pkgrelease]    = '1'

  normal[:ruby][:full_version] = [node[:ruby][:major_version],
                                  node[:ruby][:minor_version]].join('.')
  normal[:ruby][:version] = [node[:ruby][:full_version],
                             node[:ruby][:patch_version]].join('.')
end
