Vagrant.configure("2") do |config|
  config.vm.define "web1" do |subconfig|
    config.vm.box = "laravel/homestead"
    subconfig.vm.hostname = "web1"
    subconfig.vm.network :private_network, ip: "10.0.0.10"
  end
  config.vm.define "web2" do |subconfig|
    config.vm.box = "laravel/homestead"
    subconfig.vm.hostname = "web2"
    subconfig.vm.network :private_network, ip: "10.0.0.11"
  end
  # config.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: "~/.ssh/me.pub"
  
  config.vm.provision :shell, privileged: false do |s|
    ssh_pub_key = File.readlines("#{Dir.home}/.ssh/id_rsa.pub").first.strip
    s.inline = <<-SHELL
      echo #{ssh_pub_key} >> /home/$USER/.ssh/authorized_keys
    SHELL
  end

  config.vm.provider "virtualbox" do |v|
    v.memory = 512
  end
end