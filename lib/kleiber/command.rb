# encoding: utf-8

require_relative 'terminal'

module Kleiber
  # Command in order to interact through CLI
  # @author Bobykin Kirill <qelphybox@gmail.com>
  class Command
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
      @command_parts = []
    end

    def execute
      `#{@command_parts.join(' ')}`
    end
  end
end
