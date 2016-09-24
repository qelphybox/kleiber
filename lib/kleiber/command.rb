# encoding: utf-8

require_relative 'terminal'

module Kleiber
  # Command in order to interact through CLI
  # @author Bobykin Kirill <qelphybox@gmail.com>
  class Command
    class Vagrant
      UP        = 'up'
      SSH       = 'ssh'
      HALT      = 'halt'
      RELOAD    = 'reload'
      DESTROY   = 'destroy'
      PROVISION = 'provision'
    end

    COMMANDS = Vagrant.constants.map { |c| Vagrant.const_get c }

    attr_accessor :project, :symphony_command, :tasks
    # Creates new instance
    # @param project [Project] Project working for
    # @param vagrant_command [String] vagrant command
    # @param tasks = '' [String] tasks to execute
    # @return [Command]
    def initialize(project, vagrant_command, tasks = '')
      @project = project
      @vagrant_command = vagrant_command
      @tasks = tasks
    end

    def execute
      `#{command_parts.join(' ')}`
    end

    private

    def command_parts
      # up  - vagrant up
      # ssh - vagrant ssh
      @command_parts ||= parts
    end

    def parts
      if tasks.empty?
        send(vagrant_command)
      else
        # TODO: implement command compose
      end
    end

    def ssh_exec
      %(#{ssh} -c "cd /vagrant && %{ssh_command}")
    end

    def method_missing(method, *args)
      if COMMANDS.include?(method.to_s)
        "vagrant #{method}"
      else
        super
      end
    end

    def respond_to_missing?(method, include_private = false)
      COMMANDS.include?(method.to_s) || super
    end
  end
end
