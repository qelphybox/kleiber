# encoding: utf-8

require 'fileutils'

module Kleiber
  # Provides access to settings of library
  # @author Кирилл Бобыкин <qelphybox@gmail.com>
  class Settings
    # backporting for old ruby versions
    REQUIRED_KEYS = %w(name prefix path guest_port host_port host).map(&:to_sym)

    attr_accessor :path

    def initialize(path)
      @path = path
    end

    # Returns projects settings hash
    # @return [Array] projects hash
    def projects
      config[:projects]
    end

    # Returns tasks settings hash
    # @return [Hash] tasks hash
    def tasks
      config[:tasks]
    end

    # Returns terminal settings
    # @return [Hash]
    def terminal
      config[:terminal]
    end

    # Validates settings
    # @return [Boolean] validation result
    def valid?
      config[:projects].all? { |p| (REQUIRED_KEYS - p.keys).empty? }
    end

    private

    def config
      YAML.load_file(@path)
    end
  end
end
