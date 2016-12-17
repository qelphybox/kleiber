# encoding: utf-8

module Kleiber
  # Provides api for symphony perphomance
  # @author Кирилл Бобыкин <qelphybox@gmail.com>
  class Performer
    attr_reader :symphony, :projects
    def initialize(symphony, projects, options)
      @symphony = symphony
      @projects = projects
      @tasks    = options[:tasks]
    end

    # Generates vagrant api methods
    # @example
    #   def up
    #     symphony.up(projects, task_names)
    #   end
    %i(up ssh halt reload).each do |sym|
      define_method sym do
        symphony.send(sym, projects, tasks)
      end
    end

    # Returns array of task names
    # @return [Array] task names
    def task_names
      @tasks ? @tasks.split(':') : []
    end

    # Returns tasks to run with command
    # @return [Hash] tasks to run
    def tasks
      all_tasks = Kleiber.settings.tasks
      task_names.each_with_object({}) { |t, hash| hash[t] = all_tasks[t] if all_tasks.key?(t) }
    end
  end
end
