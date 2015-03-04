
time_obj=Time.now
time_str=time_obj.strftime("%Y-%m-%d--%H-%M-%S").to_s

execute "backup hosts file" do
    command "cp /etc/hosts /etc/hosts_#{time_str}"    
end



ruby_block "modify hosts" do
  block do
    file = Chef::Util::FileEdit.new("/etc/hosts")
    file.insert_line_if_no_match(
      "Additional wordpress multisite installation records",
      "# Additional wordpress multisite installation records \n192.168.56.110 site1.test.com \n192.168.56.116 site2.test.com \n192.168.56.115 test.com"
    )
    file.write_file
  end
end