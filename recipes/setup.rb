::Chef::Recipe.send(:include, Opscode::OpenSSL::Password)
node.set_unless['wordpress']['setup']['admin_password'] = secure_password

execute 'wp core install' do
  action :run
  command %Q|#{Chef::Config[:file_cache_path]}/wp \
    --path='#{node['wordpress']['dir']}' \
    core install \
    --title='#{node['wordpress']['setup']['title']}' \
    --admin_user='#{node['wordpress']['setup']['admin_user']}' \
    --admin_password='#{node['wordpress']['setup']['admin_password']}' \
    --admin_email='#{node['wordpress']['setup']['admin_email']}' \
    --url='#{node['wordpress']['setup']['url']}'|
  not_if %Q|#{Chef::Config[:file_cache_path]}/wp \
    --path='#{node['wordpress']['dir']}' \
    core is-installed|
end
