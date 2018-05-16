BOX_IMAGE = "ubuntu/trusty64"
NODES = 2

Vagrant.configure("2") do |config|

  config.vm.define "master", primary: true do |master|
    master.vm.box = BOX_IMAGE
    master.vm.network "private_network", ip: "192.168.10.10"
    master.vm.hostname = "master"
    master.vm.synced_folder "salt/", "/srv/salt", id: "states"
    master.vm.synced_folder "pillar", "/srv/pillar", id: "pillars"

    master.vm.provision :salt do |salt|
      salt.master_config = "salt/minion-configs/master"
      salt.install_master = true
      salt.no_minion = true
    end

  end

  (1..NODES).each do |i|
    config.vm.define "web#{i}" do |minion|
      minion.vm.box = BOX_IMAGE
      minion.vm.network "private_network", ip: "192.168.10.1#{i}"
      minion.vm.network "forwarded_port", guest: 8000, host: "800#{i}", auto_correct: true
      minion.vm.hostname = "web#{i}"

      minion.vm.provision :salt do |salt|
        salt.minion_config = "salt/minion-configs/web-minion"
      end

    end
  end

  config.vm.define "loadbalancer" do |loadbalancer|
    loadbalancer.vm.box = BOX_IMAGE
    loadbalancer.vm.network "private_network", ip: "192.168.10.20"
    loadbalancer.vm.network "forwarded_port", guest: 80, host: "8020", auto_correct: true
    loadbalancer.vm.network "forwarded_port", guest: 443, host: "8030", auto_correct: true
    loadbalancer.vm.hostname = "loadbalancer"

    loadbalancer.vm.provision :salt do |salt|
      salt.minion_config = "salt/minion-configs/load-balancing-minion"
    end

  end

end
