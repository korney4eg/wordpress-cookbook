#
# Cookbook Name:: wordpress
# Recipe:: database
# Author:: Lucas Hansen (<lucash@opscode.com>)
# Author:: Julian C. Dunn (<jdunn@getchef.com>)
# Author:: Craig Tracey (<craigtracey@gmail.com>)
#
# Copyright (C) 2013, Chef Software, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#


mysql_service 'server' do
  port '3306'
  version '5.5'
  socket '/var/lib/mysql/mysql.sock'
  initial_root_password 'qwaszx@1'
  action [:create, :start]
end

mysql_config 'server' do
  source 'server.cnf.erb'
  instance 'server'
  notifies :restart, 'mysql_service[server]'
  action :create
end

mysql2_chef_gem 'default' do
  action :install
end

#::Chef::Recipe.send(:include, Opscode::OpenSSL::Password)
::Chef::Recipe.send(:include, Wordpress::Helpers)

node.set['wordpress']['db']['pass'] = secure_password unless node['wordpress']['db']['pass']
node.save unless Chef::Config[:solo]

db = node['wordpress']['db']

if is_local_host? db['host']

  mysql_connection_info = {
    :host     => 'localhost',
    :username => 'root',
    :password => node['mysql']['server_root_password']
  }

  mysql_database db['name'] do
    connection  mysql_connection_info
    action      :create
  end

  mysql_database_user db['user'] do
    connection    mysql_connection_info
    password      db['pass']
    host          db['host']
    database_name db['name']
    action        :create
  end

  mysql_database_user db['user'] do
    connection    mysql_connection_info
    database_name db['name']
    privileges    [:all]
    action        :grant
  end
end
