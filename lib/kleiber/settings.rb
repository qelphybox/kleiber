# encoding: utf-8

module Kleiber
  # Provides access to settings of library
  # @author Кирилл Бобыкин <qelphybox@gmail.com>
  class Settings
    # backporting for old ruby versions
    REQUIRED_KEYS = %w(prefix path guest_port host_port host).map(&:to_sym)

    def initialize(path)
      @path = path
      raise('Wrong config') unless valid?
    end

    # Returns projects settings hash
    # @return [Hash] projects hash
    def projects
      yaml_config[:projects]
    end

    # Returns tasks settings hash
    # @return [Hash] tasks hash
    def tasks
      yaml_config[:tasks]
    end

    def valid?
      yaml_config[:projects].values.all? { |p| (REQUIRED_KEYS - p.keys).empty? }
    end

    private

    def yaml_config
      YAML.load_file(@path)
    end
  end
end
