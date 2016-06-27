# encoding: utf-8

require 'json'

module Kleiber
  class Project
    class Config
      class Storage
        def initialize(config)
          @path = "#{config.path}/.kleiber"
          @config = config.instance_variables.inject({}) do |hash, var|
            hash.merge(var[1..-1].to_sym => config.instance_variable_get(var))
          end
        end

        def exist?
          File.exist?("#{@path}/storage")
        end

        def store
          FileUtils.mkdir_p(@path)
          json_config = @config.to_json
          File.open("#{@path}/storage", 'w') { |f| f.write(json_config) }
        end

        def apply_config!
          @config_hash.each do |key, value|
            @config.send("#{key}=", value)
          end
        end

        def config_hash
          JSON.parse(File.read("#{@path}/storage"), symbolize_names: true)
        end

        def clean
          FileUtils.rm_rf(@path)
        end
      end
    end
  end
end
