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

      # Returns stored symphony by id
      # @param [String] id
      # @return [Symphony] symphony
      def get(id)

      end

      # Returns array with all symphonies, which kleiber knows
      # @return [Array] symphonies array
      def list

      end

      # Deletes symphony by id
      # @param [String] id
      # @return [Boolean] result
      def destroy(id)

      end
    end

    def initialize(name, projects)
      @name = name
      @projects = projects
    end
  end
end
