require 'fileutils'

module Kleiber
  ROOT = File.absolute_path("#{__dir__}/..")
end

Dir['kleiber/*'].each { |file| require_relative file }
