BOX_IMAGE = "centos/7"
NODES = 2

Vagrant.configure("2") do |config|
  
  config.vm.define "master", primary: true do |master|
    master.vm.box = BOX_IMAGE
    master.vm.network "private_network", ip: "192.168.10.10"
  end

  (1..NODES).each do |i|
    config.vm.define "web#{i}" do |minion|
      minion.vm.box = BOX_IMAGE
      minion.vm.network "private_network", ip: "192.168.10.1#{i}"
    end
  end

end
