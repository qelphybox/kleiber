# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.require_version '>= 1.8.3'

Vagrant.configure(2) do |config|
  config.vm.box = 'ubuntu/trusty64'
  config.vm.provision :ansible_local do |ansible|
    ansible.playbook = '/vagrant/cm/vagrant.yml'
  end
end
