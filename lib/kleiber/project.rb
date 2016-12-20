# encoding: utf-8

module Kleiber
  # Provides api to control such project
  # @author Кирилл Бобыкин <qelphybox@gmail.com>
  class Project
    include Commands
    attr_reader :name, :prefix, :path, :guest_port, :host_port, :host
    def initialize(settings)
      @name       = settings[:name]
      @prefix     = settings[:prefix]
      @path       = settings[:path]
      @guest_port = settings[:guest_port]
      @host_port  = settings[:host_port]
      @host       = settings[:host]
      @tasks      = settings[:tasks]
      @env        = settings[:env]
    end

    VARS = {
      host: 'HOST',
      guest_port: 'PORT'
    }

    def env
      @env || {}
    end

    def tasks
      @tasks || {}
    end

    # Return env variables of this project
    # @return [Hash]
    def environment
      @env_vars ||= VARS.reduce({}) do |hash, (key, value)|
        hash.merge("#{prefix}_#{value}" => send(key))
      end.merge(env)
    end

    %i(up ssh halt reload).each do |sym|
      define_method sym do |params|
        terminal_execute(command_with(__method__, params))
      end
    end

    # Returns command with option to run
    # @param [Hash] params params need run with
    # @return [String] command line
    def command_with(command, params)
      ["cd #{path}", send("handle_#{command}", params)].join(' && ')
    end
  end
end
