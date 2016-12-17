# encoding: utf-8

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'kleiber'
require 'factory_girl'
require 'byebug'

SPEC_ROOT = __dir__
Dir["#{__dir__}/support/helpers/*.rb"].each { |helper| require helper }
Dir["#{__dir__}/shared/**/*.rb"].each { |helper| require helper }

RSpec.configure do |config|
  config.include FixturesSpecHelper
  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    FactoryGirl.find_definitions
  end

  config.before(:all) do
    Kleiber.configure do |c|
      c.path = good_config_path
    end
  end
end
