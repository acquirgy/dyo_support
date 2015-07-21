# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'

settings = YAML.load_file 'vagrant.yml'

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "ubuntu/trusty64"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network "private_network", ip: "192.168.53.102"

  if settings['vm']['synced_folder']['type'] == 'rsync'
    config.vm.synced_folder ".", "/vagrant", type: settings['vm']['synced_folder']['type'],
      rsync__exclude: [".git/", "*.sqlite3", "log/", "tmp/", "node_modules", "bower_components", ".vagrant"]
  else
    config.vm.synced_folder ".", "/vagrant", type: settings['vm']['synced_folder']['type']
  end

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", "1024"]
  end

  config.vm.provision "shell", privileged: false, path: "provision.sh"
end
