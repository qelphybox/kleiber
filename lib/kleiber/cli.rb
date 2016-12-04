# encoding: utf-8

require 'thor'
require_relative 'symphony'

module Kleiber
  class CLI < Thor
    option :config, aliases: :c

    desc 'up', 'Send vagrant up to machines'
    method_option :tasks, type: :string, aliases: :t
    def up(*projects)
      Symphony.new(:up, options: options, projects: projects).perform
    end

    desc 'ssh', 'Send vagrant ssh to machines'
    method_option :tasks, type: :string, aliases: :t
    def ssh(*projects)
      Symphony.new(:ssh, options: options, projects: projects).perform
    end

    desc 'halt', 'Send vagrant halt to machines'
    def halt(*projects)
      Symphony.new(:halt, options: options, projects: projects).perform
    end

    desc 'reload', 'Send vagrant reload to machines'
    method_option :tasks, type: :string, aliases: :t
    def reload(*projects)
      Symphony.new(:reload, options: options, projects: projects).perform
    end

    desc 'destroy', 'Send vagrant destroy to machines'
    def destroy(*projects)
      Symphony.new(:destroy, options: options, projects: projects).perform
    end

    desc 'provision', 'Send provision vagrant to machines'
    def provision(*projects)
      Symphony.new(:provision, options: options, projects: projects).perform
    end
  end
end
