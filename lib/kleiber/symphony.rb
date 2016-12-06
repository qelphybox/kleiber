# encoding: utf-8

module Kleiber
  # Model describes session of performances your vagrants.
  # Provides api for control your symphony.
  # @author Bobykin Kirill <qelphybox@gmail.com>
  class Symphony
    attr_reader :projects, :name

    def initialize(name, projects)
      @name     = name
      @projects = projects
    end

    # Calls up for symphony projects
    # @param [Array] *only only this project names
    def up(*only)
      select_projects(only).each(&:up)
    end

    # Selects project from projects
    # @param only [Array] projects for filter
    # @return [Array] result array
    def select_projects(only)
      only.empty? ? projects : projects.select { |p| only.include?(p.name) }
    end
  end
end
