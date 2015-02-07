#
# Author:: Barry Steinglass (<barry@opscode.com>)
# Author:: Koseki Kengo (<koseki@gmail.com>)
# Author:: Lucas Hansen (<lucash@opscode.com>)
# Author:: Julian C. Dunn (<jdunn@getchef.com>)
#
# Cookbook Name:: wordpress
# Attributes:: wordpress
#
# Copyright 2009-2013, Chef Software, Inc.
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

# General settings
default['wordpress']['version'] = 'latest'
default['wordpress']['server_aliases'] = '10.6.206.229'
default['wp-cli']['dir'] = '/tmp'

default['wordpress']['db']['name'] = "wp"
default['wordpress']['db']['user'] = "wp_user"
default['wordpress']['db']['pass'] = "qwaszx@1"
default['wordpress']['db']['prefix'] = 'wp_'
default['wordpress']['db']['host'] = '127.0.0.1'
default['mysql']['server_root_password'] = 'qwaszx@1'

default['wordpress']['server_aliases'] = ['local']
default['wordpress']['db']['theme'] = 'twentyfifteen'

# Languages
default['wordpress']['languages']['lang'] = ''
default['wordpress']['languages']['version'] = ''
default['wordpress']['languages']['repourl'] = 'http://translate.wordpress.org/projects/wp'
default['wordpress']['languages']['projects'] = ['main', 'admin', 'admin_network', 'continents_cities']
default['wordpress']['languages']['themes'] = []
default['wordpress']['languages']['project_pathes'] = {
  'main'              => '/',
  'admin'             => '/admin/',
  'admin_network'     => '/admin/network/',
  'continents_cities' => '/cc/'
}
%w{ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen twenty}.each do |year|
  default['wordpress']['languages']['project_pathes']["twenty#{year}"] = "/twenty#{year}/"
end
node['wordpress']['languages']['project_pathes'].each do |project,project_path|
  # http://translate.wordpress.org/projects/wp/3.5.x/admin/network/ja/default/export-translations?format=mo
  default['wordpress']['languages']['urls'][project] =
    node['wordpress']['languages']['repourl'] + '/' +
    node['wordpress']['languages']['version'] + project_path +
    node['wordpress']['languages']['lang'] + '/default/export-translations?format=mo'
end

if platform_family?('windows')
  default['wordpress']['parent_dir'] = "#{ENV['SystemDrive']}\\inetpub"
  default['wordpress']['dir'] = "#{node['wordpress']['parent_dir']}\\wordpress"
  default['wordpress']['url'] = "https://wordpress.org/wordpress-#{node['wordpress']['version']}.zip"
else
  default['wordpress']['parent_dir'] = '/var/www'
  default['wordpress']['dir'] = "#{node['wordpress']['parent_dir']}/wordpress"
  default['wordpress']['url'] = "https://wordpress.org/wordpress-#{node['wordpress']['version']}.tar.gz"
end
