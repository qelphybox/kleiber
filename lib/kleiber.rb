# encoding: utf-8

require 'yaml'

module Kleiber
  ROOT = File.absolute_path("#{__dir__}/..")
  DEFAULT_SETTINGS_PATH = File.expand_path('.projects.yml', ENV['HOME'])

  autoload :Settings,   'kleiber/settings'
  autoload :Symphony,   'kleiber/symphony'
  autoload :Project,    'kleiber/project'
  autoload :Terminal,   'kleiber/terminal'

  class << self
    # Returns projects which kleiber can operate
    # @return [Array] projects
    def projects
      settings.projects.map do |project_settings|
        Project.new(project_settings)
      end
    end

    # Returns symphonies which kleiber can control
    # @return [Array] symphonies
    def symphonies
      settings.symphonies.map do |symphony_name, symphony_settings|
        symp_projects = projects.select { |p| symphony_settings[:projects].include?(p.name) }
        Symphony.new(symphony_name, symp_projects)
      end
    end

    # Provides blockparam settings for configure
    # @yieldparam [Settings] settings
    def configure
      yield settings
    end

    # Returns settings if library
    # @return [Settings] settings
    def settings
      @settings ||= Settings.new(DEFAULT_SETTINGS_PATH)
    end

    # Returns current terminal object
    # @return [Terminal] current terminal
    def terminal
      @terminal ||= Terminal.new(settings.terminal)
    end
  end
end
