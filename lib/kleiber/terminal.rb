# encoding: utf-8

module Kleiber
  # Provides objects with command patterns for particular terminal
  # @author Bobykin Kirill <qelphybox@gmail.com>
  class Terminal
    def initialize(name = 'xfce4-terminal')
      @name = name
      @command = JSON.parse(IO.read("#{ROOT}/resources/terminals/#{@name}.json"), sybolize_names: true)
    end

    def execute(command)
      # TODO: implent execute
    end

    private

    def new_tab(title = nil)
      `#{@command[:exec]} #{@command[:new_tab]} #{@command[:set_title]} }`
    end
  end
end
