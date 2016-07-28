
require 'yaml'

settings = YAML.load_file 'vagrant_config.yml'

Vagrant.configure(2) do |config|
  config.vm.box = "geerlingguy/centos6"
  config.vm.synced_folder "../", "/cookbooks", type: "virtualbox"

  APP_NODE_COUNT = 3

  #build ip array for app servers
  values = settings['app_start']['ip_address'].split(".")
  network = "#{values[0]}.#{values[1]}.#{values[2]}."
  start_host="#{values[3]}"

  ip_array=Array.new()

  APP_NODE_COUNT.times do |i|
      host=start_host.to_i+i
      ip_addr = "#{network}#{host}"
      ip_array.push(ip_addr)

      node_id = "wp-app#{i}"
      config.vm.define node_id do |node|
      node.vm.hostname = "#{node_id}"
      node.vm.network "private_network", ip: ip_addr

      node.vm.provision "chef_solo" do |chef|
          chef.json = {
                "wordpress" => {
                    "lb" => {
                      "host" => settings['lb']['ip_address']
                    },
                    "db" => {
                      "host" => settings['db']['ip_address']
                    }
                 }
          }
          chef.data_bags_path = "data_bags"
          chef.encrypted_data_bag_secret_key_path = "data_bag_key"
          chef.cookbooks_path = ".."
          chef.add_recipe "wordpress"
      end

    end
  end

  config.vm.define "lb" do |lb|
       lb.vm.hostname = "wp-lb"
       lb.vm.network "private_network", ip: settings['lb']['ip_address']
       lb.vm.provision "chef_solo" do |chef|
               chef.json = {
                     "wordpress" => {
                         "ip_array" => ip_array
                     }
               }
               chef.cookbooks_path = ".."
               chef.add_recipe "wordpress::nginx"
       end
  end

  config.vm.define "db" do |db|
      db.vm.hostname = "wp-db"
      db.vm.network "private_network", ip: settings['db']['ip_address']
      db.vm.provision "chef_solo" do |chef|
             chef.json = {
                    "wordpress" => {
                        "ip_array" => ip_array
                    }
              }
              chef.data_bags_path = "data_bags"
             chef.encrypted_data_bag_secret_key_path = "data_bag_key"
             chef.cookbooks_path = ".."
             chef.add_recipe "wordpress::database"
      end
  end


end
