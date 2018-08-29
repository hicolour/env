# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.box = "archlinux/archlinux"

  config.vm.provider "virtualbox" do |vb|
     vb.gui = true

     vb.memory = "2048"
  end

  config.vm.provision "shell", inline: <<-SHELL

    sudo pacman -S --noconfirm git
    sudo pacman -S --noconfirm make

    cd ~/
    git clone https://github.com/hicolour/.personal-exmaple.git .personal

    git clone https://github.com/hicolour/env.git
    


    # sudo wget -O /opt/eclipse-java-luna-SR2-linux-gtk-x86_64.tar.gz http://ftp.fau.de/eclipse/technology/epp/downloads/release/luna/SR2/eclipse-java-luna-SR2-linux-gtk-x86_64.tar.gz
    # cd /opt/ && sudo tar -zxvf eclipse-java-luna-SR2-linux-gtk-x86_64.tar.gz
  SHELL
end
