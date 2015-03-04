

default['wordpressnfs']['shared_folder']='/home/wordpress_upload'
default['wordpressnfs']['mount_folder']='/var/www/wordpress/wp-content/uploads'
default['wordpressnfs']['nfs_server']="192.168.56.115"
default['wordpressnfs']['nfs_clients']=%w[192.168.56.110(rw,async) 192.168.56.116(rw,async)]
