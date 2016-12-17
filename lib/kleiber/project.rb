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
    end

    %i(up ssh halt reload).each do |sym|
      define_method sym do |tasks_to_run|
        Kleiber.terminal.in_new_tab(command_with(__method__, tasks_to_run))
      end
    end

    # Returns command with option to run
    # @param [Hash] task_list task list to run with command
    # @return [String] command line
    def command_with(command, task_list)
      send("handle_#{command}", task_list)
    end

    # Returns environment variables of this project
    # @return [<type>] <description>
    def environment

    end

    # Provides block to operate at home directory, after block it turns back
    def in_directory
      pwd = Dir.getwd
      Dir.chdir(path)
      yield
      Dir.chdir(pwd)
    end

    private

    # Returns vagrant command
    # @param [Symbol, String] command vagrant command
    # @return [String] command line
    def vagrant_(command)
      send("vagrant_#{command}".to_sym).command
    end
  end
end
