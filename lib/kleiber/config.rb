# encoding: utf-8

require 'fileutils'
require_relative 'config_storage'

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

      attr_accessor :path, :name, :prefix, :guest_port, :host_port, :host

      STORAGE_PATH = "#{ROOT}/.kleiber"

      def initialize(args)
        @path = args['path']
        @name = args['name']
        @prefix = args['prefix']
        @storage = Storage.new(self)
        load_configuration!
      end

      def stored?
        @storage.exist?
      end

      private

      # FIXME: horrible

      def load_configuration!
        if stored?
          @storage.apply_config!
          store_config!
        else
          set_host!
          set_ports!
        end
      end

      def set_ports!
        FileUtils.chdir(@path)
        cmd = <<-SHELL
          unset RUBYLIB
          /usr/bin/vagrant port
        SHELL
        ports = ''
        Thread.new { ports = `#{cmd}` }.join
        ports = ports.scan(/\s+(\d+)\s\(guest\)\s=>\s(\d+)\s\(host\)/).reject { |m| %w(22 2222).sort == m.sort }.first
        @guest_port = ports[0]
        @host_port = ports[1]
      end

      def set_host!
        FileUtils.chdir(@path)
        ifconfig = ''
        cmd = <<-SHELL
          unset RUBYLIB
          /usr/bin/vagrant up --no-provision &> /dev/null
          /usr/bin/vagrant ssh -c 'ifconfig'
        SHELL
        Thread.new { ifconfig = `#{cmd}` }.join
        @host = parse_ifconfig(ifconfig).first.first
      end

      def parse_ifconfig(ifconfig)
        ifconfig.scan(/inet\saddr:(192.168.\d+.\d+)/)
      end
    end
  end
end
