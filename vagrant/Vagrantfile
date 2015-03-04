
vm_synced_folder="/usr/local/cookbooks"
local_cookbooks_path="librarian-chef/cookbooks"
vm_provision_path="/tmp/chef-solo"


# Vagrant::Config.run do |config|
#   config.vm.forward_port 80, 8080
# end



Vagrant.configure("2") do |config|
#   config.vm.provision "shell", inline: "sudo setenforce permissive && iptables -F"
# !   config.librarian_chef.cheffile_dir = "librarian-chef"
#  config.vbguest.auto_update = false





  config.vm.define "test2_db" do |t2|
    t2.vm.box = "test2/centos7_db.box"
    t2.vm.hostname="test2-centos7-db"
    t2.vm.synced_folder local_cookbooks_path, vm_synced_folder
    t2.vm.network "private_network", ip: "192.168.56.111"

      
    t2.vm.provision "chef_solo" do |chef|
      chef.provisioning_path="#{vm_provision_path}"
      chef.custom_config_path='librarian-chef/solo.rb'
#      chef.cookbooks_path = "#{local_cookbooks_path}"
      chef.verbose_logging= "true"
      chef.add_recipe "separatedb"
    end
    
    
    t2.vm.provision "shell",inline: 'sudo ln -sf /opt/VBoxGuestAdditions-4.3.10/lib/VBoxGuestAdditions /usr/lib/VBoxGuestAdditions' 
    
    t2.vm.provider :virtualbox do |vb|
      vb.name = "test2-centos7-db"
      vb.memory = 512
      vb.cpus = 1     
    end   
  end





  config.vm.define "test3" do |t3|
#    t3.vm.provision "shell",inline: 'yum -y install kernel-devel'
    t3.vm.provision "shell",inline: 'sudo ln -sf /opt/VBoxGuestAdditions-4.3.10/lib/VBoxGuestAdditions /usr/lib/VBoxGuestAdditions' 
    t3.vm.box = "test3/centos7.box"
    t3.vm.hostname='balancer-test.com'
    t3.vm.synced_folder local_cookbooks_path, vm_synced_folder
    t3.vm.network "private_network", ip: "192.168.56.115"

      
    t3.vm.provision "chef_solo" do |chef|
      chef.provisioning_path="#{vm_provision_path}"
      chef.custom_config_path='librarian-chef/solo.rb'
      chef.verbose_logging= "true"
      chef.add_recipe "balancer"
    end
    
        
    t3.vm.provider :virtualbox do |vb|
      vb.name = "test3-centos7-balancer"
      vb.memory = 512
      vb.cpus = 1     
    end   
  end






  config.vm.define "test1" do |t1|
    t1.vm.box = "test1/centos7_1.box"
    t1.vm.hostname='site1.test.com'
    t1.vm.synced_folder local_cookbooks_path, vm_synced_folder
    t1.vm.network "private_network", ip: "192.168.56.110" 
    t1.vm.network "forwarded_port", guest: 80, host: 8080
    

    t1.vm.provision "shell",inline: "cp -rf #{vm_synced_folder} #{vm_provision_path}"
      
    t1.vm.provision "chef_solo" do |chef|
      chef.add_recipe "wordpress"
      chef.add_recipe "wordpress::wp_cli"
      chef.add_recipe "wordpress::security"
      chef.provisioning_path="#{vm_provision_path}"
      chef.custom_config_path='librarian-chef/solo.rb'
      chef.verbose_logging= "true"
    end
    
    t1.vm.provision "shell",inline: 'sudo ln -sf /opt/VBoxGuestAdditions-4.3.10/lib/VBoxGuestAdditions /usr/lib/VBoxGuestAdditions' 
    
    t1.vm.provider :virtualbox do |vb|
      vb.name = "test1-centos7"
      vb.memory = 1024
      vb.cpus = 2     
    end   

  end


  config.vm.define "test4" do |t4|
    t4.vm.box = "test4/centos7.box"
    t4.vm.hostname='site2.test.com'
    t4.vm.synced_folder local_cookbooks_path, vm_synced_folder
    t4.vm.network "private_network", ip: "192.168.56.116" 
    t4.vm.network "forwarded_port", guest: 80, host: 8081
    

    t4.vm.provision "shell",inline: "cp -rf #{vm_synced_folder} #{vm_provision_path}"
      
    t4.vm.provision "chef_solo" do |chef|
      chef.add_recipe "wordpress"
      chef.add_recipe "wordpress::wp_cli"
      chef.add_recipe "wordpress::security"
      chef.provisioning_path="#{vm_provision_path}"
      chef.custom_config_path='librarian-chef/solo.rb'
      chef.verbose_logging= "true"
    end
    
    t4.vm.provision "shell",inline: 'sudo ln -sf /opt/VBoxGuestAdditions-4.3.10/lib/VBoxGuestAdditions /usr/lib/VBoxGuestAdditions' 
    
    t4.vm.provider :virtualbox do |vb|
      vb.name = "test4-centos7-app"
      vb.memory = 1024
      vb.cpus = 2     
    end   

  end




end




