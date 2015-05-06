Description
===========

The Chef Wordpress cookbook installs and configures Wordpress according to the instructions at http://codex.wordpress.org/Installing_WordPress. You can also use it to install wp-cli and themes.

Requirements
============

Platform
--------

* Ubuntu
* RHEL/CentOS
* Windows

Cookbooks
---------

* mysql
* php
* apache2
* iis
* windows
* openssl (uses library to generate secure passwords)

Recipes
==========

* `wordpress::default` - Installs WordPress site.
* `wordpress::wp-cli` - Installs wp-cli utility (http://wp-cli.org/).
* `wordpress::setup` - Setups WordPress site.
* `wordpress::theme` - Installs and activates theme from market or cookbook directory.

Attributes
==========

### WordPress

* `node['wordpress']['version']` - Version of WordPress to download. Use 'latest' to download most recent version.
* `node['wordpress']['parent_dir']` - Parent directory to where WordPress will be installed.
* `node['wordpress']['dir']` - Location to place WordPress files.
* `node['wordpress']['db']['name']` - Name of the WordPress MySQL database.
* `node['wordpress']['db']['host']` - Host of the WordPress MySQL database.
* `node['wordpress']['db']['user']` - Name of the WordPress MySQL user.
* `node['wordpress']['db']['pass']` - Password of the WordPress MySQL user. By default, generated using openssl cookbook.
* `node['wordpress']['db']['prefix']` - Prefix of all MySQL tables created by WordPress.

### wp-cli

* `node['wordpress']['wp-cli']['install_path']` - Path to wp-cli executable.
* `node['wordpress']['wp-cli']['download_url']` - Download URL for wp-cli.

### setup

* `node['wordpress']['setup']['title']` - WordPress site title.
* `node['wordpress']['setup']['admin_user']` - Administrator login name.
* `node['wordpress']['setup']['admin_email']` - Administrator email address.
* `node['wordpress']['setup']['url']` - WordPress site URL.

### setup: admin password

* `node['wordpress']['setup']['admin_password']['value']` - Administrator password. If 'nil', then will generate a random one unless 'from_databag' equals 'true'.
* `node['wordpress']['setup']['admin_password']['from_databag']` - If 'true' then indicates that 'value' from above should be ignored, and further the value is obtained from data bag.
* `node['wordpress']['setup']['admin_password']['databag']` - Data bag to get the value for password from.
* `node['wordpress']['setup']['admin_password']['databag_item']` - Corresponding data bag item.
* `node['wordpress']['setup']['admin_password']['databag_item_key']` - Corresponding data bag item key to get value from.

### theme

Use `node['wordpress']['theme']['source_dir']` parameter to define theme sourcing method:

* `public` to install from https://wordpress.org/themes/.
* `cookbook` to install from `<cookbook-path>/files/default/<name>/`

`node['wordpress']['theme']['name']` - Theme name at the market OR local directory name with theme files.

Usage
=====

Add the "wordpress" recipe to your node's run list or role, or include the recipe in another cookbook.

License and Author
==================

* Author:: Barry Steinglass (barry@opscode.com)
* Author:: Joshua Timberman (joshua@opscode.com)
* Author:: Seth Chisamore (schisamo@opscode.com)
* Author:: Lucas Hansen (lucash@opscode.com)
* Author:: Julian C. Dunn (jdunn@getchef.com)

Copyright:: 2010-2013, Chef Software, Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
