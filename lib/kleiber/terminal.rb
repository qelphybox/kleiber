# encoding: utf-8

module Kleiber
  # Provides objects with command patterns for particular terminal
  # @author Bobykin Kirill <qelphybox@gmail.com>
  class Terminal
    # Defines a terminal by pid of system command process
    # @return [Terminal] New instance of terminal
    def self.define
      teminal_name = ''
      Tread.new { teminal_name = `#{ROOT}/kleiber/scripts/which_terminal.sh` }.join
      new(terminal_name)
    end

    def initialize(name = 'xfce4-terminal')
      @name = name
      @command = JSON.parse(IO.read("#{ROOT}/resources/terminals/#{@name}.json"), sybolize_names: true)
    end

    def new_tab(title = nil)
      `#{@command[:exec]} #{@command[:new_tab]} #{@command[:set_title]} }`
    end

    def execute(command)

    end
  end
end
