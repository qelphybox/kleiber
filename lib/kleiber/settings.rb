# encoding: utf-8

require 'fileutils'
require 'yaml'

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

    # Returns symphonies settings
    # @return [Hash]
    def symphonies
      config[:symphonies]
    end

    # Validates settings
    # @return [Boolean] validation result
    def valid?
      private_methods.map do |m|
        send(m) if m.to_s.start_with?('validate_')
      end.compact.all?
    end

    private

    def validate_symphonies
      symphonies && symphonies.is_a?(Hash) &&
        symphonies.values.all? do |symp|
          symp.key?(:projects) && symp[:projects].is_a?(Array) &&
            symp[:projects].all? { |p| projects.map { |e| e[:name] }.include?(p) }
        end
    end

    def validate_projects
      projects && projects.is_a?(Array) &&
        projects.all? { |p| (REQUIRED_KEYS - p.keys).empty? }
    end

    def config
      YAML.load_file(@path)
    end
  end
end
