# encoding: utf-8

require 'cocaine'

module Kleiber
  module Commands
    def vagrant
      Cocaine::CommandLine.new('/usr/bin/vagrant')
    end

    # Returns vagrant up command line
    # @return [Cocaine::CommandLine] vagrant up command
    def vagrant_up
      Cocaine::CommandLine.new(vagrant.command, 'up')
    end

    # Returns vagrant ssh command line
    # @return [Cocaine::CommandLine] vagrant ssh command
    def vagrant_ssh
      Cocaine::CommandLine.new(vagrant.command, 'ssh')
    end

    # Returns vagrant halt command line
    # @return [Cocaine::CommandLine] vagrant halt command
    def vagrant_halt
      Cocaine::CommandLine.new(vagrant.command, 'halt')
    end

    # Returns vagrant destroy command line
    # @return [Cocaine::CommandLine] vagrant destroy command
    def vagrant_destroy
      Cocaine::CommandLine.new(vagrant.command, 'destroy')
    end

    # Returns vagrant provision command line
    # @return [Cocaine::CommandLine] vagrant provision command
    def vagrant_provision
      Cocaine::CommandLine.new(vagrant.command, 'provision')
    end

    # Executes command in new tab
    # @param [String] command command line to run
    def terminal_execute(command)
      with_tmpfile_script(command) do |file|
        Kleiber.terminal.execute(file)
      end
    end

    # Provides command to execute within temporary bashscript file
    # @param [String] command to execute
    # @yieldparam [File] file bashcript to use in terminal instance
    def with_tmpfile_script(command)
      Tempfile.create([name, '.sh'], '/tmp') do |file|
        file.chmod(0_755)
        file.write(scriptify(command))
        file.close
        yield file
      end
    end

    # Returns text of bashscript file with command
    # @param [String] command command line to execute
    # @return [String] scriptlike string
    def scriptify(command)
      ['#!/bin/bash', 'unset RUBYLIB', command].join("\n")
    end

    # Returns command line for `vagrant up` command.
    # Evaluates tasks executions line by taken parameters
    # @param [Hash] params params hash with values to execute with
    # @return [String] line for vagrant up execution
    def handle_up(params)
      line = [vagrant_(:up)]
      line << handle_ssh(params) unless params[:tasks].empty?
      line.join(' && ')
    end

    def handle_ssh(params)
      line = [vagrant_(:ssh)]
      line << ssh_exec_line(params) unless params[:tasks].empty?
      line.join(' ')
    end

    # Returns option which executes tasks in vagrant
    # @example
    #   "-c 'FIRST_HOST=192.168.22.20 cd /vagrant && bundle exec rails server'"
    # @param [Hash] params params hash with values to execute with
    # @return [String] option
    def ssh_exec_line(params)
      Cocaine::CommandLine.new('', '-c :in_machine').command(in_machine: in_machine(params))
    end

    # Returns commandline need to execute in vagrant machine.
    # Actually, it's an environment settings and chain of tasks
    # @example
    #   'FIRST_HOST=192.168.22.20 cd /vagrant && bundle exec rails server'
    # @param [Hash] params params hash with values to execute with
    # @return [String]
    def in_machine(params)
      [apply_env_line(params[:env]), tasks_line(params[:tasks])].join(' ')
    end

    # Returns tasks chain command line
    # @param [Hash] tasks_to_run final defined tasks hash
    # @example
    #   'cd /vagrant && bundle install --binstubs && bundle exec rackup'
    # @return [String] tasks commandline
    def tasks_line(tasks_to_run)
      line = ['cd /vagrant']
      line += tasks_to_run.reduce({}) do |result, (key, value)|
        result.merge(key => tasks[key] || value)
      end.values
      line.join(' && ')
    end

    # Returns string of environment variable definitions
    # @param [Hash] env_to_app final defined environment variables list
    # @example
    #   'FIRST_HOST=192.168.22.20 FIRST_PORT=3030 SECOND_HOST=192.168.22.21 SECOND_PORT=3030'
    # @return [String] environment definition string
    def apply_env_line(env_to_app)
      env_to_app.map { |e| e.join('=') }.join(' ')
    end

    # Returns vagrant command
    # @param [Symbol, String] command vagrant command
    # @return [String] command line
    def vagrant_(command)
      send("vagrant_#{command}".to_sym).command
    end
  end
end
