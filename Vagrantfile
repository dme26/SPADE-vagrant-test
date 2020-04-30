# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # config.vm.provider "virtualbox" do |vb|
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end

  config.vm.provision "shell", privileged: false, inline: <<-SHELL
    # Install OpenJDK
    sudo add-apt-repository -y ppa:openjdk-r/ppa
    sudo apt-get update
    sudo apt-get install -y openjdk-8-jdk

    # Install other SPADE dependencies
    sudo apt-get install -y auditd fuse git ifupdown libaudit-dev libfuse-dev linux-headers-`uname -r` lsof pkg-config unzip uthash-dev curl cmake clang
    
    # Download and build SPADE
    cd
    git clone https://github.com/ashish-gehani/SPADE.git
    cd SPADE
    ./configure
    # NOTE: make wget less noisy on console when downloading Neo4j
    # could be done setting WGETRC or ~/.wgetrc
    sed -e 's/wget /wget --progress=dot:giga /g' -i'' ~/SPADE/bin/downloadNeo4j
    make
    cd

    # NOTE: Patch memory defaults to run on toy VM
    sed -e 's/-Xms8G/-Xms400M/g' -e 's/-Xmx16G/-Xmx500M/g' -i'' ~/SPADE/bin/spade

    /vagrant/test-spade.sh
    
  SHELL
end
