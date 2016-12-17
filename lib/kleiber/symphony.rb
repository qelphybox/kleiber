# encoding: utf-8

module Kleiber
  # Model describes session of performances your vagrants.
  # Provides api for control your symphony.
  # @author Bobykin Kirill <qelphybox@gmail.com>
  class Symphony
    attr_reader :projects, :name, :tasks

    def initialize(name, projects, tasks)
      @name     = name
      @projects = projects
      @tasks    = tasks
    end

    # Generates vagrant api methods
    # @param [Array] only only this project names
    # @param [Array] tasks
    # @example
    #   def up(only, tasks)
    #     select_projects(only).each { |p| p.up(tasks) }
    #   end
    %i(up ssh halt).each do |sym|
      define_method sym do |only, tasks_to_run|
        select_projects(only).each { |p| p.send(sym, task_list(tasks_to_run)) }
      end
    end

    # Selects project from projects
    # @param only [Array] projects for filter
    # @return [Array] result array
    def select_projects(only)
      only.empty? ? projects : projects.select { |p| only.include?(p.name) }
    end

    # Defines symphony task values, if it exists
    # @param [Hash] list list of tasks to run
    # @return [Hash] task list with symphony values
    def task_list(list)
      list.each_with_object({}) do |(name, task), hash|
        hash[name] = tasks[name] || task
      end
    end
  end
end
