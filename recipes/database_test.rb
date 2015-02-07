mysql2_chef_gem 'default' do
	  action :install
end

files = node['wordpress']['db']['theme']


mysql_connection_info = {
  :host     => '10.6.206.229',
  :username => 'root',
  :password => 'qwaszx@1',
  :database => 'wp'
}

Chef::Log.info("*** Changing Wordpress theme to Twenty Fifteen ***")

files.each do |file|
  mysql_database 'wp' do
    connection mysql_connection_info
    sql "UPDATE wp_options SET option_value = \'twentyfourteen\' WHERE option_name = \'#{file}\';"
    action :query
  end
end
