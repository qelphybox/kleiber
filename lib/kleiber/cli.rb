# encoding: utf-8
require 'thor'
require_relative 'symphony'

module Kleiber
  class CLI < Thor
    option :config, aliases: :c
    option :option, aliases: :o

    desc 'up', 'send vagrant up to machines'
    def up(*projects)
      Symphony.new('up', options: options, projects: projects) #.exec
    end

    desc 'ssh', 'send vagrant ssh to machines'
    def ssh(*projects)
      Symphony.new('ssh', options: options, projects: projects) #.exec
    end

    desc 'halt', 'send vagrant halt to machines'
    def halt(*projects)
      Symphony.new('halt', options: options, projects: projects) #.exec
    end

    desc 'reload', 'send vagrant reload to machines'
    def reload(*projects)
      Symphony.new('reload', options: options, projects: projects) #.exec
    end

    desc 'destroy', 'send vagrant destroy to machines'
    def destroy(*projects)
      Symphony.new('destroy', options: options, projects: projects) #.exec
    end

    desc 'provision', 'send provision vagrant to machines'
    def provision(*projects)
      Symphony.new('provision', options: options, projects: projects) #.exec
    end
  end
end
