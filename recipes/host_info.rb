template "#{node['wordpress']['dir']}/hostinfo.html" do
  source 'host_info.html.erb'
  
  variables(
    :host_platform    => node['platform'],
    :host_ip          => node['ipaddress'],
    :host_fqdn	      => node['fqdn'],
    :host_version     => node['platform_version']
    )
    
  action :create
end
 