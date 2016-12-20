# encoding: utf-8

module Kleiber
  # Class Terminal provides api for current terminal
  # @author Кирилл Бобыкин <qelphybox@gmail.com>
  class Terminal
    attr_reader :exec, :new_tab, :title, :exec_command
    def initialize(settings)
      @exec         = settings[:exec]
      @new_tab      = settings[:new_tab]
      @title        = settings[:title]
      @exec_command = settings[:exec_command]
    end

    # Runs command line in new tab
    # @param [String] line line to execute
    def execute(scriptfile)
      puts command_line.command(script: scriptfile.path)
      command_line.run(script: scriptfile.path)
    end

    private

    # Returns CommandLine for execution
    # @param [File] scriptfile file with script to execute in machine
    # @return [Cocaine::CommandLine] new command line to execute
    def command_line
      Cocaine::CommandLine.new(exec, options)
    end

    # Return options line
    # @return [String] terminal options line
    def options
      options_line = ['-e :script']
      options_line.unshift(title) if title
      options_line.unshift(new_tab) if new_tab
      options_line.join(' ')
    end
  end
end
