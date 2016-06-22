# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = 'ubuntu/trusty64'
  config.vm.provision 'shell', keep_color: true, inline: <<-SHELL
    sudo apt-get update
    sudo apt-get install software-properties-common git -y
    sudo apt-add-repository ppa:brightbox/ruby-ng -y
    sudo apt-get update
    sudo apt-get install ruby2.3 ruby2.3-dev build-essential zlib1g-dev -y
    gem install bundler
  SHELL
end
