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
        execute(command_with(__method__, params))
      end
    end

    # Returns command with option to run
    # @param [Hash] params params need run with
    # @return [String] command line
    def command_with(command, params)
      send("handle_#{command}", params)
    end

    # Executes command in new tab
    # @param [String] command command line to run
    def execute(command)
      Kleiber.terminal.in_new_tab(command)
    end

    # Provides block to operate at home directory, after block it turns back
    def in_directory
      pwd = Dir.getwd
      Dir.chdir(path)
      yield
      Dir.chdir(pwd)
    end

    private

    def handle_up(params)
      # byebug
      line = [vagrant_(:up)]
      line << ssh_exec_line(params) unless params[:tasks].empty?
      line.join(' && ')
    end

    def ssh_exec_line(params)
      "#{vagrant_(:ssh)} -c '#{apply_env_line(params[:env])} #{tasks_line(params[:tasks])}'"
    end

    def tasks_line(tasks_to_run)
      tasks_to_run.reduce({}) do |result, (key, value)|
        result.merge(key => tasks[key] || value)
      end.values.join(' && ')
    end

    def apply_env_line(env_to_app = nil)
      env_to_app.map { |e| e.join('=') }.join(' ')
    end

    # Returns vagrant command
    # @param [Symbol, String] command vagrant command
    # @return [String] command line
    def vagrant_(command)
      send("vagrant_#{command}".to_sym).command
    end
  end
end
