# encoding: utf-8

require 'yaml'

module Kleiber
  ROOT = File.absolute_path("#{__dir__}/..")
  DEFAULT_SETTINGS_PATH = File.expand_path('.projects.yml', ENV['HOME'])

  autoload :Settings, 'kleiber/settings'
  autoload :Symphony, 'kleiber/symphony'
  autoload :Project, 'kleiber/project'

  class << self
    def create(name, project_names)
      Symphony.create(name, projects)
    end

    def settings
      @settings ||= Settings.new()
    end
  end
end
