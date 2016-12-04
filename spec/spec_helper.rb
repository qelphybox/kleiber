# encoding: utf-8

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'kleiber'
Dir["#{__dir__}/support/helpers/*.rb"].each { |helper| require helper }

FIXTURES_PATH = "#{__dir__}/fixtures"
