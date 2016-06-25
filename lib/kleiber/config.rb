# encoding: utf-8

module Kleiber
  class Project
    class Config
      class << self
        def parse_config(config_path)
          config_path ||= ENV['KLEIBER_CONFIG']
          raise 'You have to define Kleiber projects ' \
                'configuration by variable KLEIBER_CONFIG or option -c' unless config_path
          projects = YAML.load_file(config_path)
          check_config!(projects)
          projects.map { |p| new(p) }
        end

        private

        def check_config!(config)
          required_keys = %w(name prefix path)
          resolution = config.all? do |hash|
            (hash.keys & required_keys).sort == required_keys.sort
          end
          raise("Wrong config, required keys: #{required_keys.join(', ')}") unless resolution
        end
      end

      def initialize(args)
        @path = args['path']
        @name = args['name']
        @prefix = args['prefix']
        load_configuration!
      end

      private

      def load_configuration!
        vm_info
      end

      def vm_info
        puts log_file
      end

      def log_file
        log_path = "#{@path}/tmp/#{Time.now.to_i}_vagrant.log"
        puts "cd #{@path} && vagrant up --no-provision --debug &> #{log_path}"
        Thread.new { `cd #{@path} && vagrant up --no-provision --debug &> #{log_path}` }.join
        result = IO.read(log_path)
        Thread.new { `rm #{log_path}` }
        result
      end
    end
  end
end
