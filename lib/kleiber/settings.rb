# encoding: utf-8

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
      yaml_config[:projects]
    end

    # Returns tasks settings hash
    # @return [Hash] tasks hash
    def tasks
      yaml_config[:tasks]
    end

    def valid?
      yaml_config[:projects].all? { |p| (REQUIRED_KEYS - p.keys).empty? }
    end

    private

    def yaml_config
      YAML.load_file(@path)
    end
  end
end
