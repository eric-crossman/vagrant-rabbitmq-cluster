Vagrant.configure("2") do |config|

  config.vm.define "rabbit-1" do |rabbit1|
    rabbit1.vm.box = "centos/7"
    rabbit1.vm.hostname = "rabbit-1.local"
    config.vm.provider "virtualbox" do |v|
      v.memory = 512
      v.cpus =1
    end
  end

  config.vm.define "rabbit-2" do |rabbit2|
    rabbit2.vm.box = "centos/7"
    rabbit2.vm.hostname = "rabbit-2.local"
    config.vm.provider "virtualbox" do |v|
      v.memory = 512
      v.cpus =1
    end
  end

  config.vm.define "rabbit-3" do |rabbit3|
    rabbit3.vm.box = "centos/7"
    rabbit3.vm.hostname = "rabbit-3.local"
    config.vm.provider "virtualbox" do |v|
      v.memory = 512
      v.cpus =1
    end
  end

end
