# encoding: utf-8

require 'cocaine'

module Kleiber
  module Commands
    def vagrant
      Cocaine::CommandLine.new('/usr/bin/vagrant')
    end

    # Returns vagrant up command line
    # @return [Cocaine::CommandLine] vagrant up command
    def vagrant_up
      Cocaine::CommandLine.new(vagrant.command, 'up')
    end

    # Returns vagrant ssh command line
    # @return [Cocaine::CommandLine] vagrant ssh command
    def vagrant_ssh
      Cocaine::CommandLine.new(vagrant.command, 'ssh')
    end

    # Returns vagrant halt command line
    # @return [Cocaine::CommandLine] vagrant halt command
    def vagrant_halt
      Cocaine::CommandLine.new(vagrant.command, 'halt')
    end

    # Returns vagrant destroy command line
    # @return [Cocaine::CommandLine] vagrant destroy command
    def vagrant_destroy
      Cocaine::CommandLine.new(vagrant.command, 'destroy')
    end

    # Returns vagrant provision command line
    # @return [Cocaine::CommandLine] vagrant provision command
    def vagrant_provision
      Cocaine::CommandLine.new(vagrant.command, 'provision')
    end
  end
end
