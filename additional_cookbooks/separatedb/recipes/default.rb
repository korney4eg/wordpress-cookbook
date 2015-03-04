#
# Cookbook Name:: separate-db
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "openssl"

execute "selinux disable" do
    command "setenforce permissive"    
end

script "security setup" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
    firewall-cmd --zone=public --add-port=3306/tcp --permanent
    firewall-cmd --reload
  EOH
end




mysql_client 'default' do
    action :create
  end
  
mysql_service 'default' do
  port '3306'
  version '5.5'
  bind_address node['separatedb']['db_node_ip']
  data_dir '/wordpress_data'
  initial_root_password 'oasis'
  Chef::Provider::MysqlService::Systemd
  action [:create, :start]
end



::Chef::Recipe.send(:include, Opscode::OpenSSL::Password)
::Chef::Recipe.send(:include, Separatedb::Helpers)






# node.set_unless['wordpress']['db']['pass'] = secure_password


db = node['separatedb']['db']



#if is_local_host? db['host']
  # include_recipe "mysql::server"



  mysql_bin = (platform_family? 'windows') ? 'mysql.exe' : 'mysql'
  user = "'#{db['user']}'"
  create_user_remote = %<CREATE USER #{user}@'%' IDENTIFIED BY '#{db['pass']}';>
  user_exists_remote = %<SELECT 1 FROM mysql.user WHERE user = '#{db['user']}';>
  create_db = %<CREATE DATABASE #{db['name']};>
  db_exists = %<SHOW DATABASES LIKE '#{db['name']}';>
  grant_privileges_remote = %<GRANT ALL PRIVILEGES ON #{db['name']}.* TO #{user}@'%';>
  privileges_exist_remote = %<SHOW GRANTS FOR for #{user};>
  flush_privileges = %<FLUSH PRIVILEGES;>

#db_exists=`#{mysql_bin} #{::Separatedb::Helpers.make_db_query("root", node['mysql']['server_root_password'], db_exists)}`
#Chef::Log.warn("*****cmd: #{mysql_bin} #{::Separatedb::Helpers.make_db_query("root", node['mysql']['server_root_password'], db_exists)} *****")
#Chef::Log.warn("*****cmd_res: #{db_exists} *****")

#if (!db_exists.match(/wordpressdb/))


  execute "Create WordPress MySQL User remote" do
    action :run
    command " #{mysql_bin} #{::Separatedb::Helpers.make_db_query("root", node['mysql']['server_root_password'], create_user_remote)}"
    only_if { `#{mysql_bin} #{::Separatedb::Helpers.make_db_query("root", node['mysql']['server_root_password'], user_exists_remote)}`.empty? }
  end

  execute "Grant WordPress MySQL Privileges remote" do
    action :run
    command "#{mysql_bin} #{::Separatedb::Helpers.make_db_query("root", node['mysql']['server_root_password'], grant_privileges_remote)}"
    only_if { `#{mysql_bin} #{::Separatedb::Helpers.make_db_query("root", node['mysql']['server_root_password'], privileges_exist_remote)}`.empty? }
    notifies :run, "execute[Flush MySQL Privileges]"
  end

  execute "Flush MySQL Privileges" do
    action :nothing
    command "#{mysql_bin} #{::Separatedb::Helpers.make_db_query("root", node['mysql']['server_root_password'], flush_privileges)}"
  end

  execute "Create WordPress Database" do
    action :run
    command "#{mysql_bin} #{::Separatedb::Helpers.make_db_query("root", node['mysql']['server_root_password'], create_db)}"
    only_if { `#{mysql_bin} #{::Separatedb::Helpers.make_db_query("root", node['mysql']['server_root_password'], db_exists)}`.empty? }
  end
#end


