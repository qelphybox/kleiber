# encoding: utf-8

module Kleiber
  class Terminal
    def initialize(name = 'xfce4-terminal')
      @name = name
      @command = JSON.parse(IO.read("#{ROOT}/resources/terminals/#{@name}.json"), sybolize_names: true)
    end

    def new_tab(title = nil)
      `#{@command[:exec]} #{@command[:new_tab]} #{@command[:set_title] % { title: title } if title} }`
    end
  end
end
