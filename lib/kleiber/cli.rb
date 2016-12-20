# encoding: utf-8

require 'thor'

module Kleiber
  # Class CLI provides command line interface for kleiber
  # @author Кирилл Бобыкин <qelphybox@gmail.com>
  class CLI < Thor
    desc 'up SYMPHONY_NAME [PROJECTS]', 'runs vagrant up for projects'
    method_option :tasks, type: :string, aliases: '-t'
    def up(symphony_name, *projects)
      Kleiber.perform(symphony_name, projects, options).up
    end

    desc 'ssh SYMPHONY_NAME [PROJECTS]', 'runs vagrant ssh for projects'
    method_option :tasks, type: :string, aliases: '-t'
    def ssh(symphony_name, *projects)
      Kleiber.perform(symphony_name, projects, options).ssh
    end

    desc 'reload SYMPHONY_NAME [PROJECTS]', 'runs vagrant reload for projects'
    method_option :tasks, type: :string, aliases: '-t'
    def reload(symphony_name, *projects)
      Kleiber.perform(symphony_name, projects, options).reload
    end

    desc 'halt SYMPHONY_NAME [PROJECTS]', 'runs vagrant halt for projects'
    def halt(symphony_name, *projects)
      Kleiber.perform(symphony_name, projects, options).halt
    end
  end
end
