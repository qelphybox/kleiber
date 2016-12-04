# encoding: utf-8

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'kleiber'
SPEC_ROOT = __dir__
Dir["#{__dir__}/support/helpers/*.rb"].each { |helper| require helper }
Dir["#{__dir__}/shared/**/*.rb"].each { |helper| require helper }

RSpec.configure do |config|
  config.include FixturesSpecHelper

  config.before(:all) do
    Kleiber.configure do |c|
      c.path = good_config_path
    end
  end
end
