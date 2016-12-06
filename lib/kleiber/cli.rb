# encoding: utf-8

require 'thor'

module Kleiber
  # Class CLI provides command line interface for kleiber
  # @author Кирилл Бобыкин <qelphybox@gmail.com>
  class CLI < Thor
    desc 'up SYMPHONY_NAME [PROJECTS]', 'runs vagrant up for projects' # [4]
    method_options force: :boolean, alias: :string # [5]
    def up(symphony_name, *projects)
      # Kleiber.perform(symphony_name, projects, options).up
    end
  end
end
