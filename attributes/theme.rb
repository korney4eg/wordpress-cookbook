# Use 'source_dir' parameter to define theme sourcing method:
# - 'public' to install from https://wordpress.org/themes/
# - 'cookbook' to install from <cookbook-path>/files/default/
default['wordpress']['theme']['source_dir'] = 'public'
default['wordpress']['theme']['name'] = 'custom-community'

# parameters below are ignored while 'source_dir' = 'cookbook'
default['wordpress']['theme']['version'] = nil # 'nil' equals latest
default['wordpress']['theme']['filename'] = "#{node['wordpress']['theme']['name']}#{node['wordpress']['theme']['version']}.zip"
default['wordpress']['theme']['directory_download_url'] = 'https://downloads.wordpress.org/theme'
default['wordpress']['theme']['download_url'] = "#{node['wordpress']['theme']['directory_download_url']}/#{node['wordpress']['theme']['filename']}"
