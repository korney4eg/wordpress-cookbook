default['wordpress']['setup']['title'] = 'My WordPress'
default['wordpress']['setup']['admin_user'] = 'wp-admin'
default['wordpress']['setup']['admin_password'] = nil # if 'nil' then will generate a random one
default['wordpress']['setup']['admin_email'] = 'wp-admin@example.local'
default['wordpress']['setup']['url'] = "http://#{node['hostname']}"
