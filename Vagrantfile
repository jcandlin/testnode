# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  config.vm.provision :puppet, :module_path => "puppet/modules" do |puppet|
     puppet.manifests_path = "puppet/manifests"
     puppet.manifest_file = "site.pp"
  end

    config.vm.define "testnode" do |testnode|
    testnode.vm.box = "precise64"
    testnode.vm.box_url = "http://files.vagrantup.com/precise64.box"
    testnode.vm.hostname = "testnode"
    testnode.vm.network "private_network", ip: "192.168.33.21"
    testnode.vm.network :forwarded_port, guest: 80, host: 8080
  end

  # Every Vagrant virtual environment requires a box to build off of.
    config.vm.box = "precise64"
  end