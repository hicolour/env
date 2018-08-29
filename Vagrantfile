# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.box = "archlinux/archlinux"

  config.vm.provider "virtualbox" do |vb|
     vb.gui = true

     vb.memory = "2048"
  end

  pacman_conf = <<-CONF
  [archlinuxfr]
  SigLevel = Never
  Server = http://repo.archlinux.fr/\\$arch
  CONF

  config.vm.provision "shell", inline: <<-SHELL


    echo "Pacman conffiguration"
    egrep --quiet "^[archlinuxfr]" /etc/pacman.conf
    if [ $? -ne 0 ]; then
      sudo sh -c "echo '#{pacman_conf}' >> /etc/pacman.conf"
    fi

    # sudo echo "[archlinuxfr]" >> /etc/pacman.conf
    # sudo echo "SigLevel = Never" >> /etc/pacman.conf
    # sudo echo "Server = http://repo.archlinux.fr/\\$arch" >> /etc/pacman.conf

    sudo pacman -Suy

    sudo pacman -S --noconfirm git
    sudo pacman -S --noconfirm make

    mkdir -p /home/vagrant/projects/personal/

    git clone https://github.com/hicolour/.personal-exmaple.git /home/vagrant/projects/personal/.personal-example

    ln -s /home/vagrant/projects/personal/.personal-example /home/vagrant/.personal
    echo "this=hal9000" > /home/vagrant/.personal/this


    git clone https://github.com/hicolour/env.git /home/vagrant/projects/personal/env

    cd /home/vagrant/projects/personal/env
    
    make base


    # sudo wget -O /opt/eclipse-java-luna-SR2-linux-gtk-x86_64.tar.gz http://ftp.fau.de/eclipse/technology/epp/downloads/release/luna/SR2/eclipse-java-luna-SR2-linux-gtk-x86_64.tar.gz
    # cd /opt/ && sudo tar -zxvf eclipse-java-luna-SR2-linux-gtk-x86_64.tar.gz
  SHELL
end
