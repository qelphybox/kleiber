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

    # Returns tasks of this project
    # @return [Hash]
    def tasks
    end

    # Provides block to operate at home directory, after block it turns back
    def in_directory
      pwd = Dir.getwd
      Dir.chdir(path)
      yield
      Dir.chdir(pwd)
    end
  end
end
