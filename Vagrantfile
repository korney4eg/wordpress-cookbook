Vagrant.configure(2) do |config|
  config.vm.box = "geerlingguy/centos6"
    config.vm.synced_folder "../", "/cookbooks", type: "virtualbox"
  
   config.vm.define "lb" do |lb|
      lb.vm.box = "geerlingguy/centos6"
      lb.vm.hostname = "wp-lb"
      lb.vm.network "private_network", ip: "192.168.50.7"
      lb.vm.provision "chef_solo" do |chef|
              chef.cookbooks_path = ".."
              chef.add_recipe "wordpress::nginx"
      end
   end

   config.vm.define "db" do |db|
        db.vm.box = "geerlingguy/centos6"
        db.vm.hostname = "wp-db"
        db.vm.network "private_network", ip: "192.168.50.4"

        db.vm.provision "chef_solo" do |chef|
               chef.cookbooks_path = ".."
               chef.add_recipe "wordpress::database"
        end
   end

   config.vm.define "app1" do |app1|
         app1.vm.box = "geerlingguy/centos6"
         app1.vm.hostname = "wp-app1"
         app1.vm.network "private_network", ip: "192.168.50.5"

         app1.vm.provision "chef_solo" do |chef|
               chef.cookbooks_path = ".."
               chef.add_recipe "wordpress"

         end
   end

   config.vm.define "app2" do |app2|
            app2.vm.box = "geerlingguy/centos6"
            app2.vm.hostname = "wp-app2"
            app2.vm.network "private_network", ip: "192.168.50.6"

            app2.vm.provision "chef_solo" do |chef|
                  chef.cookbooks_path = ".."
                  chef.add_recipe "wordpress"

            end
      end

end
