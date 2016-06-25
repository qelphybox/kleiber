# encoding: utf-8

require 'yaml'
require 'json'
require_relative 'project'

module Kleiber
  class Symphony
    def initialize(command, args = {})
      options = args[:options]
      @command = command
      @projects = Project.load_by_config(options[:config])
    end

    private

    def load_config(config_path)

    end
  end
end
