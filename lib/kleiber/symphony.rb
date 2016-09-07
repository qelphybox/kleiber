# encoding: utf-8

require 'yaml'
require 'json'
require_relative 'project'

module Kleiber
  # Model describes job which you want to perform.
  # Roughly speaking, this is event of command performing on defined Vagrant machines.
  # Looks like symphony of vagrants.
  # @author Bobykin Kirill <qelphybox@gmail.com>
  class Symphony
    # Creates new symphony
    # @!attribute command
    #   @return [Symbol] Vagrant command to perform
    # @!attribute args = {}
    #   @return [Hash] arguments for perfomance
    # @option args [Hash] options
    # @option args [Array] projects ([]) list of projects
    # @return [Symphony] instance of Symphony
    def initialize(command, args = {})
      options = args[:options]
      projects_by_config = Project.load_by_config(options[:config])
      @option = options[:option]
      @command = command
      @projects = if args[:projects].empty?
                    projects_by_config
                  else
                    projects_by_config.select { |p| args[:projects].include?(p.name) }
                  end
    end

    # Perform created symphony
    def perform
      # TODO: implement perfomance
    end
  end
end
