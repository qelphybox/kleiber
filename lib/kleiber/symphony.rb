# encoding: utf-8

module Kleiber
  # Model describes session of performances your vagrants.
  # Provides api for control your symphony.
  # @author Bobykin Kirill <qelphybox@gmail.com>
  class Symphony
    attr_reader :projects

    def initialize(projects)
      @projects = Project.load_by_names(projects)
    end
  end
end
