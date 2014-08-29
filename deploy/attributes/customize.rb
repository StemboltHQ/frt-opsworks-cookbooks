node[:deploy].each do |application, deploy|
  default[:deploy][application][:port] = 80
end
