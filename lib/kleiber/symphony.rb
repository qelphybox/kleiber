# encoding: utf-8

require 'yaml'
require 'json'
require_relative 'project'
require_relative 'command'

module Kleiber
  # Model describes job which you want to perform.
  # Roughly speaking, this is event of command performing on defined Vagrant machines.
  # Looks like symphony of vagrants.
  # @author Bobykin Kirill <qelphybox@gmail.com>
  class Symphony
    attr_accessor :tasks, :command, :projects
    # Creates new symphony
    # @!attribute command
    #   @return [Symbol] Vagrant command to perform
    # @!attribute args = {}
    #   @return [Hash] arguments for perfomance
    # @option args [String] tasks
    # @option args [Array] projects ([]) list of projects
    # @return [Symphony] instance of Symphony
    def initialize(command, args = { tasks: '', projects: [] })
      options = args[:options]
      projects_by_config = Project.load_by_config(options[:config])
      @tasks = options[:tasks]
      @command = command
      @projects = if args[:projects]
                    projects_by_config.select { |p| args[:projects].include?(p.name) }
                  else
                    projects_by_config
                  end
    end

    # Perform created symphony
    def perform
      terminal = Terminal.new
      @projects.each do |project|
        terminal.execute(Command.new(project, @command, @tasks))
      end
    end
  end
end
