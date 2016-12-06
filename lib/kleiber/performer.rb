# encoding: utf-8

module Kleiber
  # Provides api for symphony perphomance
  # @author Кирилл Бобыкин <qelphybox@gmail.com>
  class Performer
    def initialize(symphony, projects, options)
      @symphony = symphony
      @projects = projects
      @options  = options
    end
  end
end
