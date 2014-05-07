# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # Every vagrant virtual env requires a box to build off of
  #config.vm.box = "puppetlabs-cent65_64"
  #config.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/centos-65-x64-virtualbox-nocm.box"
  config.vm.box = "cent65-64-dave"
  config.vm.hostname = "monitorama.vm"
  config.vm.network :private_network, ip: "192.168.33.10"
  config.vm.network :forwarded_port, guest: 80, host: 8080

  # VirtualBox Specific Customization
  config.vm.provider :virtualbox do |vb|
        # Use VBoxManage to customize the VM. For example to change memory:
        vb.customize ["modifyvm", :id, "--memory", "1024"]
  end
  config.vm.provision :shell, :path => "bootstrap.sh"
  
  ## Enable provisioning with Puppet stand alone.
#  config.vm.provision :puppet do |puppet|
#        puppet.manifests_path = "puppet/manifests"
#        puppet.manifest_file  = "site.pp"
#        puppet.module_path = "puppet/modules"
#        puppet.options = "--verbose --debug"
#  end 
end
