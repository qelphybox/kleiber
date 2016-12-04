# encoding: utf-8

require_relative 'terminal'
require_relative 'project'

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

    attr_accessor :project, :vagrant_command, :tasks
    # Creates new instance
    # @param project [Project] Project working for
    # @param vagrant_command [Symbol] vagrant command
    # @param tasks = '' [String] tasks to execute
    # @return [Command]
    def initialize(project, vagrant_command, tasks = '')
      @project = project
      @vagrant_command = vagrant_command
      @tasks = tasks.split(':')
    end

    def compose
      command_parts.join(' && ')
    end

    private

    # Reader for command_parts
    # @return [Array]
    def command_parts
      @command_parts ||= parts
    end

    # Returns command_parts
    # @return [type] [description]
    def parts
      arr = [send(vagrant_command)]
      return arr if tasks.empty?
      ssh_commands = tasks.map { |t| project.task(t) }
      arr << ssh_exec(ssh_commands.join(' && '))
    end

    # Returns pattern of ssh exec command
    # @return [String]
    def ssh_exec(ssh_commands)
      %(#{ssh} -c "cd /vagrant && #{ssh_commands}")
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
