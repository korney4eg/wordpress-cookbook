remote_file "#{node['wordpress']['wp-cli']['install_path']}" do
  action :create
  source "#{node['wordpress']['wp-cli']['download_url']}"
  mode "0755"
end
