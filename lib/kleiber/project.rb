# enconding: utf-8

require_relative 'config'

module Kleiber
  # Project model describes project.
  # One project is one vagrant machine.
  # @author Bobykin Kirill <qelphybox@gmail.com>
  class Project
    class << self
      # Loads projects by configuration file with projects parameters.
      # @param config [String] path to cofiguration file
      # @return [Array] Array of projects from config.
      def load_by_config(config)
        projects = Config.parse_config(config)
        projects.map { |c| new(c) }
      end
    end

    def initialize(config)
      @state  = nil # TODO: solve state
      @config = config
    end
  end
end
