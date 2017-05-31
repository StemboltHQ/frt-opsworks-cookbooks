bash 'setup swap' do
  user 'root'
  not_if { File.exists?('/var/swapfile') }
  code <<-EOH
    dd if=/dev/zero of=/var/swapfile bs=1M count=2048
    chmod 600 /var/swapfile
    mkswap /var/swapfile
    swapon /var/swapfile
  EOH
end
