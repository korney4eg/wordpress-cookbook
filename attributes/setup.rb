default['wordpress']['setup']['title'] = 'My WordPress'
default['wordpress']['setup']['admin_user'] = 'wp-admin'

default['wordpress']['setup']['admin_password']['value'] = nil # if 'nil' then will generate a random one
default['wordpress']['setup']['admin_password']['from_data_bag'] = false # if 'true' then ignores 'admin_password' value from above and utilizes parameters below
default['wordpress']['setup']['admin_password']['secret_path'] = '/tmp/encrypted_data_bag_secret' # if properly configured, Vagrant will temporary store the secret key under /tmp/vagrant-chef/encrypted_data_bag_secret_key
default['wordpress']['setup']['admin_password']['data_bag'] = 'passwords'
default['wordpress']['setup']['admin_password']['data_bag_item'] = 'wp-admin'
default['wordpress']['setup']['admin_password']['data_bag_item_key'] = 'password'

default['wordpress']['setup']['admin_email'] = 'wp-admin@example.local'
default['wordpress']['setup']['url'] = "http://#{node['hostname']}"
