require 'kleiber/version'
require 'fileutils'
require 'yaml'

PROJECTS = ENV['PROJECTS_PATH'] || "#{ENV['HOME']}/projects"
CONFIG = ENV['KLEIBER_CONFIG'] || raise('You need to define KLEIBER_CONFIG variable.')
VAG = "#{__dir__}/vag.sh"

module Kleiber
  class RkisRunner
    def initialize(vagrant_command)
      @vagrant_command = vagrant_command
      read_projects!
      load_properties!
    end

    def run(args)
      destroy_confirm
      @rkis_projects.each do |name, settings|
        next unless args.empty? || args.include?(name)
        FileUtils.cd(settings[:dir])
        `xfce4-terminal --tab --title '#{name} vagrant' -e '#{VAG} #{ENV['GEMS_RKIS_DIR_PATH']} #{@vagrant_command} #{settings[:guest_port]} #{@discovery_properties}'`
      end
      exit(0)
    end

    private

    def read_projects!
      @rkis_projects = {}
      YAML.load_file('projects.yml').tap do |hash|
        hash.each do |project, settings|
          @rkis_projects[project] = {}
          settings.each { |k, v| @rkis_projects[project][k.to_sym] = v }
        end
      end
    end

    def destroy_confirm
      return unless @vagrant_command == 'destroy'
      print 'Confirm to destroy[yN]: '
      exit(1) if STDIN.gets.chomp.casecmp('y') < 0
    end

    def project(proj_name)
      @rkis_projects.find { |p| p[:name] == proj_name }
    end

    def load_properties!
      Dir["#{PROJECTS}/*"].each do |proj_dir|
        name = File.basename(proj_dir)
        proj_item = @rkis_projects[name]
        next unless @rkis_projects.key?(name)
        proj_item[:dir] ||= proj_dir
        proj_item[:guest_port] ||= File.read("#{proj_dir}/Vagrantfile").scan(/guest_port\s*=\s*(\d+)/).first.first
        proj_item[:host_port] ||= File.read("#{proj_dir}/Vagrantfile").scan(/host_port\s*=\s*(\d+)/).first.first
        proj_item[:host] ||= File.read("#{proj_dir}/Vagrantfile").scan(/dev_ip\s*=\s*'(.+)'/).first.first
        @discovery_properties = @rkis_projects.values.map do |v|
          "#{v[:prefix]}_HOST=#{v[:host]} #{v[:prefix]}_PORT=#{v[:host_port]}"
        end.join(' ')
      end
    end
  end
end
