# encoding: utf-8

module Kleiber
  # Model describes session of performances your vagrants.
  # Provides api for control your symphony.
  # @author Bobykin Kirill <qelphybox@gmail.com>
  class Symphony
    extend Storagable
    attr_reader :projects, :name

    class << self
      def create(name, project_names)
        # FIXME: make it persists
        current_projects = Kleiber.projects.select { |p| project_names.include?(p.name) }
        new(name, current_projects)
      end

      def get(id)

      end

      def list

      end

      def destroy(id)

      end
    end

    def initialize(name, projects)
      @name = name
      @projects = projects
    end
  end
end
