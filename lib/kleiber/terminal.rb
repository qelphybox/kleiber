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
  end
end
