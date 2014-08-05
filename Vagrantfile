# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "commana/arsnova-debian-wheezy-puppet3-i386"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  
  #config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # If true, then any SSH connections made will enable agent forwarding.
  # Default value: false
  # config.ssh.forward_agent = true

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
   config.vm.provider "virtualbox" do |vb|
  #   # Don't boot with headless mode
  #   vb.gui = true
  #
     # Use VBoxManage to customize the VM. For example to change memory:
     vb.customize ["modifyvm", :id, "--memory", "1024"]
     vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/vagrant", "1"]
   end
  #
  # View the documentation for the provider you're using for more
  # information on available options.

  # Enable provisioning with Puppet stand alone.  Puppet manifests
  # are contained in a directory path relative to this Vagrantfile.
  # You will need to create the manifests directory and a manifest in
  # the file default.pp in the manifests_path directory.
  #

  pp_manifest_path = "puppet/manifests"
  pp_module_path = "puppet/modules"
  pp_manifest_file = "default.pp"


  config.vm.provision :shell do |shell|
    shell.inline = "sudo apt-get update -y;
                    sudo apt-get install -y apt-transport-https;
                    curl -sL https://deb.nodesource.com/setup | sudo bash -;
                    sudo apt-get install -y nodejs"
  end


  config.vm.provision :hosts do |provisioner|
    provisioner.add_host '10.20.1.2', ['we3-thmcards-vg-dev.internal']
  end

  config.vm.define "we3-thmcards-vg", primary: true do |dev|
    dev.vm.hostname = "we3-thmcards-vg"
    dev.vm.provision "puppet" do |puppet|
      puppet.manifests_path = pp_manifest_path
      puppet.manifest_file = pp_manifest_file
      puppet.module_path = pp_module_path
      #puppet.options = ["--environment=development"]
      puppet.facter = {
        "vagrant_owner" => "vagrant",
        "vagrant_group" => "vagrant",
        "is_32bit" => true
      }
    end
    dev.vm.network :private_network, :ip => '10.20.1.2'
    # CouchDB
    dev.vm.network "forwarded_port", guest: 5984, host: 5984
    # THMcards
    dev.vm.network "forwarded_port", guest: 3000, host: 3000     
  end



end
