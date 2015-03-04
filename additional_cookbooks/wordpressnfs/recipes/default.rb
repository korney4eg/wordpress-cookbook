#
# Cookbook Name:: wordpressnfs
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

execute "create server folder" do
  command "mkdir -p #{node['wordpressnfs']['shared_folder']}"
  only_if {node['fqdn']=~/balancer/}        
end


execute "create client folder" do
  command "mkdir -p #{node['wordpressnfs']['mount_folder']}"
  not_if {node['fqdn']=~/balancer/}        
end


Chef::Log.warn("*****#{node['fqdn']} *****")

if (node['fqdn']=~/balancer/)
  Chef::Log.warn("***** Will create exports  file *****")
  create_exports=true
end

execute "nfs-utils install" do
  command "yum install -y nfs-utils"
end



script "enable nfs" do
  interpreter "bash"
  user "root"
  
  code <<-EOH
    
    systemctl enable rpcbind
    systemctl enable nfs-server
    systemctl enable nfs-lock
    systemctl enable nfs-idmap
    systemctl start rpcbind
    systemctl start nfs-server
    systemctl start nfs-lock
    systemctl start nfs-idmap
    
  EOH

end


execute "disable FW" do
    command "iptables -F"    
end



template "/etc/exports" do
  source 'exports.erb'
  
  variables(
  :shared_folder  =>node['wordpressnfs']['shared_folder'],
  :nfs_clients_ar =>node['wordpressnfs']['nfs_clients']
  )
    
  action :create

  only_if {node['fqdn']=~/balancer/}
  notifies :run, "script[restart nfs]"
  
end




script "restart nfs" do
  interpreter "bash"
  user "root"
  
  code <<-EOH
    systemctl restart rpcbind
    systemctl restart nfs-server
    systemctl restart nfs-lock
    systemctl restart nfs-idmap
  EOH

end

execute "mount nfs" do
  command "mount -t nfs #{node['wordpressnfs']['nfs_server']}:#{node['wordpressnfs']['shared_folder']} #{node['wordpressnfs']['mount_folder']}"
  not_if {node['fqdn']=~/balancer/}
end

execute "wp-uploads permissions" do
  command "chmod 777 #{node['wordpressnfs']['shared_folder']} -R"
  only_if {node['fqdn']=~/balancer/}
end





