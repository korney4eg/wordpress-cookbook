include_recipe 'wordpress::wp-cli'
include_recipe 'wordpress::setup'

# install theme
if node['wordpress']['theme']['source_dir'] == 'public'
  execute 'wp theme install' do
    action :run
    command %Q|#{Chef::Config[:file_cache_path]}/wp \
      --path='#{node['wordpress']['dir']}' \
      theme install \
      #{node['wordpress']['theme']['name']}|
  end
elsif node['wordpress']['theme']['source_dir'] == 'cookbook'
  if FileTest.directory?(`#{Chef::Config[:file_cache_path]}/wp --path='#{node['wordpress']['dir']}' theme path`.chomp + "/#{node['wordpress']['theme']['name']}")
    Chef::Log.warn("Theme directory for #{node['wordpress']['theme']['name']} already exists. Skipping install, and proceeding to activation.")
  else
    remote_directory `#{Chef::Config[:file_cache_path]}/wp --path='#{node['wordpress']['dir']}' theme path`.chomp + "/#{node['wordpress']['theme']['name']}" do
      source "#{node['wordpress']['theme']['name']}"
    end
  end
end

# activate theme
execute 'wp theme activate' do
  action :run
  command %Q|#{Chef::Config[:file_cache_path]}/wp \
    --path='#{node['wordpress']['dir']}' \
    theme activate \
    #{node['wordpress']['theme']['name']}|
end
