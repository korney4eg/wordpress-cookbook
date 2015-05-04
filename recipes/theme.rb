if FileTest.directory?("#{node['wordpress']['dir']}/wp-content/themes/#{node['wordpress']['theme']['name']}")
  Chef::Log.warn("Theme directory for #{node['wordpress']['theme']['name']} already exists. Skipping download and unzip actions, and moving to activation.")
else
  if node['wordpress']['theme']['source_dir'] == 'public'
    if platform_family?('windows')
      # download and unzip theme
      windows_zipfile "#{node['wordpress']['dir']}/wp-content/themes/" do
        action :unzip
        source "#{node['wordpress']['theme']['download_url']}"
      end
    else
      # download theme
      remote_file "#{Chef::Config[:file_cache_path]}/#{node['wordpress']['theme']['filename']}" do
        action :create
        source "#{node['wordpress']['theme']['download_url']}"
      end
      # unzip theme
      package 'unzip' do
        action :install
      end
      execute 'unzip theme' do
        action :run
        command "unzip #{Chef::Config[:file_cache_path]}/#{node['wordpress']['theme']['filename']} -d #{node['wordpress']['dir']}/wp-content/themes/"
      end
    end
  elsif node['wordpress']['theme']['source_dir'] == 'cookbook'
    # download theme
    remote_directory "#{node['wordpress']['dir']}/wp-content/themes/#{node['wordpress']['theme']['name']}" do
      source "#{node['wordpress']['theme']['name']}"
    end
  end
end
# activate theme
execute 'switch-theme' do
  action :run
  command %Q|php -r "include('#{node['wordpress']['dir']}/wp-load.php'); switch_theme('#{node['wordpress']['theme']['name']}');"|
end
