# encoding: utf-8

require 'fileutils'

module Kleiber
  # Provides access to settings of library
  # @author Кирилл Бобыкин <qelphybox@gmail.com>
  class Settings
    # backporting for old ruby versions
    REQUIRED_KEYS = %w(name prefix path guest_port host_port host).map(&:to_sym)
    DEFAULT_STORAGES_PATH = File.expand_path('.kleiber/stores', ENV['HOME'])

    attr_accessor :path

    def initialize(path)
      @path = path
    end

    # Returns projects settings hash
    # @return [Array] projects hash
    def projects
      yaml_config[:projects]
    end

    # Returns tasks settings hash
    # @return [Hash] tasks hash
    def tasks
      yaml_config[:tasks]
    end

    # Returns storages path value
    # @return [String] storages path
    def storages_path
      yaml_config[:storages_path] || default_storages_path
    end

    # Validates settings
    # @return [Boolean] validation result
    def valid?
      yaml_config[:projects].all? { |p| (REQUIRED_KEYS - p.keys).empty? }
    end

    private

    def default_storages_path
      FileUtils.mkdir_p(DEFAULT_STORAGES_PATH).first
    end

    def yaml_config
      YAML.load_file(@path)
    end
  end
end
