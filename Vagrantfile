# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"
  #config.vm.network "public_network", ip: "192.168.255.10"# config.vm.synced_folder "../data", "/vagrant_data"
  config.vm.provider "virtualbox" do |vb|
  config.vm.synced_folder ".", "/vagrant", type: "virtualbox"
  #config.ssh.insert_key = false
  #config.vm.provision "file", source: "id_rsa.pub", destination: "/home/vagrant/.ssh/authorized_keys"
  config.vm.provision "shell", path: "provision.sh"
  config.vm.network :forwarded_port, guest: 8090, host: 8080, host_ip: "127.0.0.1"
  #sudo systemctl restart ssh
  vb.gui = false
  vb.memory = "4096"
  vb.cpus = "4"
  vb.name = "confluence_demo"
  end
end

