$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'kleiber'
require 'rubygems'
require 'fakefs/spec_helpers'
Dir["#{__dir__}/helpers/*.rb"].each { |helper| require helper }

FIXTURES_PATH = "#{__dir__}/fixtures"

RSpec.configure do |config|
  config.include FakeFS::SpecHelpers
  ports_exception = ['unset RUBYLIB', '/usr/bin/vagrant port'].join("\n")
  host_exception = ['unset RUBYLIB',
                    '/usr/bin/vagrant up --no-provision &> /dev/null',
                    "/usr/bin/vagrant ssh -c 'ifconfig'"].join("\n")
end
