# encoding: utf-8

module Kleiber
  ROOT = File.absolute_path("#{__dir__}/..")
  DEFAULT_SETTINGS_PATH = File.expand_path('.projects.yml', ENV['HOME'])

  autoload :Settings,   'kleiber/settings'
  autoload :Symphony,   'kleiber/symphony'
  autoload :Project,    'kleiber/project'
  autoload :Terminal,   'kleiber/terminal'
  autoload :Commands,   'kleiber/commands'
  autoload :Performer,  'kleiber/performer'
  autoload :CLI,        'kleiber/cli'

  class << self
    # Returns performer with defined options
    # @param [String] symphony_name name of symphony to perform
    # @param [Array] projects list of projects names to run only
    # @param [Hash] options options of perfomance
    # @return [Performer] return performer object
    def perform(symphony_name, projects, options)
      Performer.new(symphonies[symphony_name], projects, options)
    end

    # Returns projects which kleiber can operate
    # @return [Array] projects
    def projects
      settings.projects.map do |project_settings|
        Project.new(project_settings)
      end
    end

    # Returns symphonies which kleiber can control
    # @return [Hash] symphonies
    def symphonies
      settings.symphonies.map do |symphony_name, symphony_settings|
        symp_projects = projects.select { |p| symphony_settings[:projects].include?(p.name) }
        Symphony.new(symphony_name, symp_projects, settings.tasks)
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
