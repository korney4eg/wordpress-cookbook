#
# Cookbook Name:: separate-db
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "openssl"


script "security setup" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
    firewall-cmd --zone=public --add-port=3306/tcp
    firewall-cmd --reload
    setenforce permissive
  EOH
end




mysql_client 'default' do
    action :create
  end
  

db = node['wordpress']['db']


  mysql_bin = 'mysql'
  user = "'#{db['user']}'"

  user_exists_remote = %<SELECT 1 FROM mysql.user WHERE user = '#{db['user']}'@'%';>
  db_exists = %<SHOW DATABASES LIKE '#{db['name']}';>


db_exists_res=`#{mysql_bin} #{::Wordpress::Helpers.make_db_query("root", node['mysql']['server_root_password'],db_exists,db['host'])}`
user_exists_remote_res=`#{mysql_bin} #{::Wordpress::Helpers.make_db_query("root", node['mysql']['server_root_password'], user_exists_remote,db['host'])}`

#Chef::Log.warn("*****cmd: #{mysql_bin} #{::Wordpress::Helpers.make_db_query("root", node['mysql']['server_root_password'], db_exists)} *****")
# Chef::Log.warn("*****cmd_res: #{db_exists} *****")

if (!db_exists_res)
  Chef::Log.err("***** DB not found! SQL query result: #{db_exists_res}; Query: #{mysql_bin} #{::Wordpress::Helpers.make_db_query("root", node['mysql']['server_root_password'], db_exists,db['host'])}  *****")
end

if (!user_exists_remote)
  Chef::Log.err("***** DB USER not found! SQL query result: #{user_exists_remote_res}; Query: #{mysql_bin} #{::Wordpress::Helpers.make_db_query("root", node['mysql']['server_root_password'], user_exists_remote,db['host'])}  *****")
end




