# encoding: utf-8

module Kleiber
  # Model describes session of performances your vagrants.
  # Provides api for control your symphony.
  # @author Bobykin Kirill <qelphybox@gmail.com>
  class Symphony
    attr_reader :projects, :name

    def initialize(name, projects, options)
      @name     = name
      @projects = projects
      @tasks    = options[:tasks]
      @env      = options[:env]
    end

    def tasks
      @tasks || {}
    end

    def env
      @env || {}
    end

    # Generates vagrant api methods
    # @param [Array] only only this project names
    # @param [Array] tasks
    # @example
    #   def up(only, tasks)
    #     select_projects(only).each { |p| p.up(args) }
    #   end
    %i(up ssh halt reload).each do |sym|
      define_method sym do |only, tasks_to_run|
        select_projects(only).each do |p|
          p.send(sym, tasks: task_list(tasks_to_run), env: environment)
        end
      end
    end

    # Selects project from projects
    # @param only [Array] projects for filter
    # @return [Array] result array
    def select_projects(only)
      only.empty? ? projects : projects.select { |p| only.include?(p.name) }
    end

    # Defines symphony task values and environment varaibles, if it exists
    # @param [Hash] list list of tasks to run
    # @return [Hash] task list with symphony values
    def task_list(list)
      list.each_with_object({}) do |(name, task), hash|
        hash[name] = tasks[name] || task
      end
    end

    # Returns hash with definition all env variables of this symphony
    # @return [Hash] env variables hash
    def environment
      projects.reduce(env) do |result, project|
        result.merge(project.env)
      end
    end
  end
end
