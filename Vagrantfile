# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

(1..2).each do |i|
  config.vm.define "web-#{i}" do |node|
    node.env.enable
    node.vm.box = "debian/jessie64"
    node.vm.provider "virtualbox" do |vb|
      vb.gui = false
      vb.memory = "1024"
      vb.cpus = "2"
    end
    node.ssh.insert_key = false
    node.vm.network "private_network", ip: "10.5.7.1#{i}"
    node.vm.synced_folder ".", "/vagrant", disabled: true
    node.vm.synced_folder ENV['HOST_WEB_DIR'], "/development", create:true, :owner => "vagrant", :group => "www-data", :mount_options => ["dmode=775","fmode=664"]
    node.vm.provision "file", source: "~/Boxes/guestlist/nginx.conf", destination: "~/nginx.conf"
    node.vm.hostname = "web-#{i}"
    var1= "10.5.7.1#{i}"
    var2 = "my_server"
    node.vm.provision :shell, path: "web_bootstrap.sh", :args => [var1, var2]
  end
end

i = 2

config.vm.define "lb" do |node|
  node.vm.box = "debian/jessie64"
  node.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.memory = "512"
    vb.cpus = "2"
  end
  node.ssh.insert_key = false
  node.vm.network "public_network"
  node.vm.network "private_network", ip: "10.5.7.1#{i+1}"
  node.vm.synced_folder ".", "/vagrant", disabled: true
  node.vm.provision "file", source: "~/Boxes/guestlist/nginx.conf", destination: "~/nginx.conf"
  node.vm.provision :shell, path: "lb_bootstrap.sh"
end

config.vm.define "db" do |node|
  node.env.enable
  node.vm.box = "debian/jessie64"
  node.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.memory = "1024"
    vb.cpus = "2"
  end
  node.ssh.insert_key = false
  node.vm.network "private_network", ip: "10.5.7.1#{i+2}"
  node.vm.synced_folder ".", "/vagrant", disabled: true
  node.vm.provision :shell, path: "db_bootstrap.sh"
  end
end