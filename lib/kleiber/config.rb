# encoding: utf-8

module Kleiber
  class Config
    class << self
      def parse_config(config_path)
        config_path ||= ENV['KLEIBER_CONFIG']
        raise 'You have to define Kleiber projects ' \
              'configuration by variable KLEIBER_CONFIG or option -c' unless config_path
        check_config(YAML.load_file(config_path))
      end

      private

      def check_config(config)
        required_keys = %w(name prefix path)
        resolution = config.all? do |hash|
          (hash.keys & required_keys).sort == required_keys.sort
        end
        resolution ? config : raise("Wrong config, required keys: #{required_keys.join(', ')}")
      end
    end
  end
end
