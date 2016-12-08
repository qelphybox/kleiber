# encoding: utf-8

module Kleiber
  # Provides api for symphony perphomance
  # @author Кирилл Бобыкин <qelphybox@gmail.com>
  class Performer
    attr_reader :symphony, :projects, :tasks, :stack
    def initialize(symphony, projects, tasks)
      @symphony = symphony
      @projects = projects
      @tasks    = tasks
      @stack    = []
    end

    def up
      symphony.up(projects, tasks)
    end

    def tasks
      @tasks ? @tasks.split(':') : []
    end
  end
end
