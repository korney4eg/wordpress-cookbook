#
# Cookbook Name:: balancer
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe "wordpressnfs"
include_recipe "balancer::hosts"

template "/etc/yum.repos.d/nginx.repo" do
  source 'nginx.repo.erb'
  action :create
end

execute "nginx install" do
    command "yum install -y nginx"    
end

execute "disable FW" do
    command "iptables -F"    
end

template "/etc/nginx/nginx.conf" do
  source 'nginx.conf.erb'
  variables(
    
  )
  
  action :create
  # not_if {File.exists?("/etc/nginx/nginx.conf")}
#  notifies :run, "execute[nginx restart]"
end


execute "nginx restart" do
    command "systemctl restart nginx"    
end


