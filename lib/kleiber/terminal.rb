# encoding: utf-8

module Kleiber
  # Class Terminal provides api for current terminal
  # @author Кирилл Бобыкин <qelphybox@gmail.com>
  class Terminal
    def initialize(settings)
      @exec         = settings[:exec]
      @new_tab      = settings[:new_tab]
      @title        = settings[:title]
      @exec_command = settings[:title]
    end

    def in_new_tab(line)
      p line
    end
  end
end
