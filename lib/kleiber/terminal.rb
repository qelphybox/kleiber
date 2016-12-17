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
    def in_new_tab(line)
      new_tab_line_with(line).run
    end

    def new_tab_line_with(line, title = nil)
      exec_line = [exec, new_tab]
      exec_line << title if title
      exec_line << (exec_command % { tab_command: line })
      Cocaine::CommandLine.new(exec_line.join(' '))
    end
  end
end
