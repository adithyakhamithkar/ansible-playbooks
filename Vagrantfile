# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  # test_box configuration
  config.vm.define "test_box" do |test_box|
    test_box.vm.box = "ubuntu/xenial64"
    test_box.vm.network "private_network", ip: "192.168.33.10"
    #test_box.vm.network "public_network", bridge: "en0: Wi-Fi (AirPort)"
    #test_box.ssh.username = "vagrant"
    #test_box.ssh.password = "vagrant"
    config.vm.provider "virtualbox" do |test_box|
      test_box.memory = 4096
      test_box.cpus = 2
    end
    config.vm.provision "shell", inline: <<-SHELL
       sudo apt-get update
       sudo apt-get install -y python
     SHELL
  end
  # test_box1 configuration
  config.vm.define "test_box1" do |test_box1|
    test_box1.vm.box = "ubuntu/xenial64"
    test_box1.vm.network "private_network", ip: "192.168.33.11"
    #test_box1.vm.network "public_network", bridge: "en0: Wi-Fi (AirPort)"
    #test_box.ssh.username = "vagrant"
    #test_box.ssh.password = "vagrant"
    config.vm.provider "virtualbox" do |test_box1|
      test_box1.memory = 2048
      test_box1.cpus = 1
    end
    config.vm.provision "shell", inline: <<-SHELL
       sudo apt-get update
       sudo apt-get install -y python
     SHELL
  end
  # test_box2 configuration
  config.vm.define "test_box2" do |test_box2|
    test_box2.vm.box = "ubuntu/xenial64"
    test_box2.vm.network "private_network", ip: "192.168.33.12"
    #test_box2.vm.network "public_network", bridge: "en0: Wi-Fi (AirPort)"
    #test_box.ssh.username = "vagrant"
    #test_box.ssh.password = "vagrant"
    config.vm.provider "virtualbox" do |test_box2|
      test_box2.memory = 2048
      test_box2.cpus = 1
    end
    config.vm.provision "shell", inline: <<-SHELL
       sudo apt-get update
       sudo apt-get install -y python
     SHELL
  end
  # test_box3 configuration
  config.vm.define "test_box3" do |test_box3|
    test_box3.vm.box = "centos/7"
    test_box3.vm.network "private_network", ip: "192.168.33.13"
    #test_box2.vm.network "public_network", bridge: "en0: Wi-Fi (AirPort)"
    #test_box.ssh.username = "vagrant"
    #test_box.ssh.password = "vagrant"
    config.vm.provider "virtualbox" do |test_box3|
      test_box3.memory = 2048
      test_box3.cpus = 1
    end
    config.vm.provision "shell", inline: <<-SHELL
       sudo yum install -y python
     SHELL
  end
  # Run commission-new-server.yml playbook
  #config.vm.provision "ansible" do |ansible|
  #  ansible.verbose = "v"
  #  ansible.playbook = "commission-new-server.yml"
  #  ansible.inventory_path = "~/Dropbox/inventory/test-env/hosts"
  #  ansible.raw_arguments = ["-e 'inventory=test_box1'"]
  #end
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
  #  test_box.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   sudo apt-get update
  #   sudo apt-get install -y apache2
  # SHELL
end
