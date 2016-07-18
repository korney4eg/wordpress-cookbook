Vagrant.configure(2) do |config|
  config.vm.box = "geerlingguy/centos6"
  config.vm.hostname = "wordpress"
  config.vm.synced_folder "../", "/vagrant", type: "virtualbox"
  
  config.vm.provision "chef_solo" do |chef|
      chef.cookbooks_path = ".."
      chef.add_recipe "wordpress"
  end

   #config.vm.define "lb" do |lb|
   #   lb.vm.box = "geerlingguy/centos6"
   #   config.vm.hostname = "wp-lb"
   #
   #
   #end

   #config.vm.define "db" do |db|
   #   db.vm.box = "geerlingguy/centos6"
   #   config.vm.hostname = "wp-db"
   #
   #
   #end

end
