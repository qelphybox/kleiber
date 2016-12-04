require 'fileutils'

module Kleiber
  ROOT = File.absolute_path("#{__dir__}/..")
  autoload :CLI, 'kleiber/cli'
end
