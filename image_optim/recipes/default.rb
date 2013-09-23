#
# Cookbook Name:: image_optim
# Recipe:: default
#
# Copyright 2013, FreeRunning Technologies
#
# All rights reserved - Do Not Redistribute
#

bash 'install-optipng-and-pngcrush' do
  user 'root'
  code 'yum install -y optipng pngcrush'
end
