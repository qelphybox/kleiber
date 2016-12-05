# encoding: utf-8

require 'yaml'
require 'active_support/inflector'

module Kleiber
  ROOT = File.absolute_path("#{__dir__}/..")
  DEFAULT_SETTINGS_PATH = File.expand_path('.projects.yml', ENV['HOME'])

  autoload :Settings,   'kleiber/settings'
  autoload :Storagable, 'kleiber/mixins/storagable'
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
