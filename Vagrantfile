# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANT_COMMAND = ARGV[0]
Vagrant.configure(2) do |config|

  if VAGRANT_COMMAND == "ssh"
      config.ssh.username = 'other_username'
  end

  config.vm.box = "archlinux/archlinux"

  config.vm.provider "virtualbox" do |vb|
     vb.gui = true

     vb.memory = "2048"
  end


  # pacman_conf = <<-CONF
  # [archlinuxfr]
  # SigLevel = Optional TrustAll
  # Server = http://repo.archlinux.fr/\\$arch
  # CONF
  # echo "Pacman conffiguration"
  # egrep --quiet "^[archlinuxfr]" /etc/pacman.conf
  # if [ $? -ne 0 ]; then
  #   sudo sh -c "echo '#{pacman_conf}' >> /etc/pacman.conf"
  # fi

  config.vm.provision "shell", privileged: false, inline: <<-SHELL


    sudo pacman -Suy --noconfirm
    sudo pacman -S --noconfirm binutils gcc pkg-config fakeroot

    sudo pacman -S --noconfirm make git wget

    cd /tmp/
    wget --quiet https://aur.archlinux.org/cgit/aur.git/snapshot/package-query.tar.gz
    tar xzvf package-query.tar.gz
    cd package-query
    makepkg -si --noconfirm   # -s, checks for dependencies; -i, installs the pkg with pacman
    cd ..
    wget --quiet https://aur.archlinux.org/cgit/aur.git/snapshot/yaourt.tar.gz
    tar xzvf yaourt.tar.gz
    cd yaourt
    makepkg -si --noconfirm


    mkdir -p /home/vagrant/projects/personal/

    git clone https://github.com/hicolour/.personal-exmaple.git /home/vagrant/projects/personal/.personal-example

    ln -s /home/vagrant/proje--noconfirm cts/personal/.personal-example /home/vagrant/.personal
    echo "this=hal9000" > /home/vagrant/.personal/this


    git clone https://github.com/hicolour/env.git /home/vagrant/projects/personal/env

    cd /home/vagrant/projects/personal/env

    make base


    # sudo wget -O /opt/eclipse-java-luna-SR2-linux-gtk-x86_64.tar.gz http://ftp.fau.de/eclipse/technology/epp/downloads/release/luna/SR2/eclipse-java-luna-SR2-linux-gtk-x86_64.tar.gz
    # cd /opt/ && sudo tar -zxvf eclipse-java-luna-SR2-linux-gtk-x86_64.tar.gz
  SHELL
end
