$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'kleiber'
require 'rubygems'
require 'fakefs/spec_helpers'
Dir["#{__dir__}/helpers/*.rb"].each { |helper| require helper }

FIXTURES_PATH = "#{__dir__}/fixtures"

RSpec.configure do |config|
  config.include FakeFS::SpecHelpers

  config.after(:each) do
    clearfs
  end
end
