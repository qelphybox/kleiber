require 'fileutils'

module Kleiber
  ROOT = File.absolute_path("#{__dir__}/..")
end

Dir["#{__dir__}/kleiber/*.rb"].each { |file| require_relative file }
