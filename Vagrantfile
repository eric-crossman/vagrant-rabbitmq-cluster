Vagrant.configure("2") do |config|

  config.vm.define "rabbit-1" do |rabbit1|
    rabbit1.vm.box = "bento/centos-7.7"
    rabbit1.vm.hostname = "rabbit-1.local"
    rabbit1.vm.network "private_network", type: "dhcp"
    rabbit1.vm.synced_folder "/home/eric/Eyaml", "/eyaml"
    config.vm.provider "virtualbox" do |v|
      v.memory = 512
      v.cpus =1
    end
    config.vm.provision "shell", path: "./puppet_bootstrap.sh"

    config.vm.provision "shell", path: "./install_erlang.sh"

    config.vm.provision "puppet" do |puppet|
      puppet.hiera_config_path = "puppet/hiera.yaml"
      puppet.manifests_path = "puppet/manifests"
      puppet.manifest_file = "site.pp"
      puppet.module_path = "puppet/modules"
      puppet.working_directory = "/vagrant"
    end
  end

  config.vm.define "rabbit-2" do |rabbit2|
    rabbit2.vm.box = "bento/centos-7.7"
    rabbit2.vm.hostname = "rabbit-2.local"
    rabbit2.vm.network "private_network", type: "dhcp"
    rabbit2.vm.synced_folder "/home/eric/Eyaml", "/eyaml"
    config.vm.provider "virtualbox" do |v|
      v.memory = 512
      v.cpus =1
    end
    config.vm.provision "shell", path: "./puppet_bootstrap.sh"

    config.vm.provision "shell", path: "./install_erlang.sh"

    config.vm.provision "puppet" do |puppet|
      puppet.hiera_config_path = "puppet/hiera.yaml"
      puppet.manifests_path = "puppet/manifests"
      puppet.manifest_file = "site.pp"
      puppet.module_path = "puppet/modules"
      puppet.working_directory = "/vagrant"
    end
  end

  config.vm.define "rabbit-3" do |rabbit3|
    rabbit3.vm.box = "bento/centos-7.7"
    rabbit3.vm.hostname = "rabbit-3.local"
    rabbit3.vm.network "private_network", type: "dhcp"
    rabbit3.vm.synced_folder "/home/eric/Eyaml", "/eyaml"
    config.vm.provider "virtualbox" do |v|
      v.memory = 512
      v.cpus =1
    end
    config.vm.provision "shell", path: "./puppet_bootstrap.sh"

    config.vm.provision "shell", path: "./install_erlang.sh"

    config.vm.provision "puppet" do |puppet|
      puppet.hiera_config_path = "puppet/hiera.yaml"
      puppet.manifests_path = "puppet/manifests"
      puppet.manifest_file = "site.pp"
      puppet.module_path = "puppet/modules"
      puppet.working_directory = "/vagrant"
    end
  end

end
