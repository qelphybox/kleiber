# encoding: utf-8

module Kleiber
  # Provides api to control such project
  # @author Кирилл Бобыкин <qelphybox@gmail.com>
  class Project
    attr_reader :name, :prefix, :path, :guest_port, :host_port, :host, :tasks
    def initialize(settings)
      @name       = settings[:name]
      @prefix     = settings[:prefix]
      @path       = settings[:path]
      @guest_port = settings[:guest_port]
      @host_port  = settings[:host_port]
      @host       = settings[:host]
      @tasks      = settings[:tasks]
    end

    def up

    end
  end
end
