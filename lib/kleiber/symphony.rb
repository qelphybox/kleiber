# encoding: utf-8

module Kleiber
  # Model describes session of performances your vagrants.
  # Provides api for control your symphony.
  # @author Bobykin Kirill <qelphybox@gmail.com>
  class Symphony
    extend Storagable
    attr_reader :projects, :name

    class << self
      # Creates new symphony
      # @param [String] name
      # @param [Array] project_names
      # @return [Symphony] new symphony
      def create(name, project_names)

      end

      # Returns stored symphony by name
      # @param [String] name
      # @return [Symphony] symphony
      def get(name)

      end

      # Returns array with all symphonies, which kleiber knows
      # @return [Array] symphonies array
      def list

      end

      # Deletes symphony by name
      # @param [String] name
      # @return [Boolean] result
      def destroy(name)

      end
    end

    def initialize(name, projects)
      @name = name
      @projects = projects
    end

    # Calls up for symphony projects
    # @param [Array] *only only this project names
    def up(*only)
      select_projects(only).each(&:up)
    end

    def select_projects(only)
      only.empty? ? projects : projects.select { |p| only.include?(p.name) }
    end
  end
end
