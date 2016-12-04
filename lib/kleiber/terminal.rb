# encoding: utf-8

module Kleiber
  # Provides objects with command patterns for particular terminal
  # @author Bobykin Kirill <qelphybox@gmail.com>
  class Terminal
    def initialize(name = 'xfce4-terminal')
      @name = name
      @terminal = JSON.parse(IO.read("#{ROOT}/resources/terminals/#{@name}.json"), sybolize_names: true)
    end

    # Executes command in new tab
    # @param command [type] [description]
    # @return [type] [description]
    def execute(command)
      new_tab(command)
    end

    private

    def new_tab(command)
      comm = @terminal[:exec_command] % { tab_command: command }
      "#{@terminal[:exec]} "\
      "#{@terminal[:new_tab]} "\
      "#{@terminal[:set_title]}} "\
      "#{comm}"
    end
  end
end
