Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/bionic64"

  config.vm.network "private_network", ip: "192.168.33.10"
  config.vm.network "forwarded_port", guest: 9200, host: 9200
  config.vm.network "forwarded_port", guest: 5601, host: 5601

  config.ssh.insert_key = true
  config.ssh.forward_agent = true

  if Vagrant.has_plugin?('vagrant-vbguest')
      config.vbguest.auto_update = false
  end

  config.vm.provider "virtualbox" do |vb|
      vb.name = "ES_Tests"
      vb.cpus = 1
      vb.memory = 2048
      vb.gui = false
  end

  config.vm.provision "shell", path: "install.sh"
end
