# encoding: utf-8

require_relative 'terminal'

module Kleiber
  # Command in order to interact through CLI
  # @author Bobykin Kirill <qelphybox@gmail.com>
  class Command
    def initialize(project, command, option = '')
      @project = project
      @symphony_command = command
      @option = option
      @command_parts = []
    end

    def execute
      `#{@command_parts.join(' ')}`
    end
  end
end
