# enconding: utf-8

require_relative 'config'

module Kleiber
  class Project
    class << self
      def load_by_config(config)
        projects = Config.parse_config(config)
        projects.each { |p| new(p) }
      end
    end

    def initialize(args)
      @name = args['name']
      @path = args['path']
      @prefix = args['path']
      @host_port
      @guest_port
      @host

      @env_vars
      @aliases
    end

  end
end
