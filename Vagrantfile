# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"
  #config.vm.provision "docker" do |d|
  #d.pull_images "mysql:5.6.36"
  #end
  config.vm.provision "shell", path: "provision.sh"
  config.vm.network :forwarded_port, guest: 443, host: 8888, host_ip: "127.0.0.1"
  #config.vm.network :forwarded_port, guest: 8090, host: 9999, host_ip: "127.0.0.1"
  config.vm.provider "virtualbox" do |vb|
  vb.gui = false
  vb.memory = "6000"
  vb.cpus = "4"
  vb.name = "confluence_demo"
  config.vm.synced_folder ".", "/vagrant", type: "virtualbox"
  end
end

