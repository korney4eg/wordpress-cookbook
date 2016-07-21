Vagrant.configure(2) do |config|
  config.vm.box = "geerlingguy/centos6"
    config.vm.synced_folder "../", "/vagrant", type: "virtualbox"
  
   #config.vm.define "lb" do |lb|
   #   lb.vm.box = "geerlingguy/centos6"
   #   lb.vm.hostname = "wp-lb"
   #
   #
   #end

   config.vm.define "db" do |db|
        db.vm.box = "geerlingguy/centos6"
        db.vm.hostname = "wp-db"
        db.vm.network "private_network", ip: "192.168.50.4"

        config.vm.provision "chef_solo" do |chef|
               chef.cookbooks_path = ".."
               chef.add_recipe "wordpress::database"
        end
   end

   config.vm.define "app" do |app|
         app.vm.box = "geerlingguy/centos6"
         app.vm.hostname = "wp-app"
         app.vm.network "private_network", ip: "192.168.50.5"

         config.vm.provision "chef_solo" do |chef|
               chef.cookbooks_path = ".."
               chef.add_recipe "wordpress"

         end
   end

end
