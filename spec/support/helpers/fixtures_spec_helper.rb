# encoding: utf-8

module FixturesSpecHelper
  FIXTURES_PATH = "#{SPEC_ROOT}/fixtures"

  def good_config_path
    fixture('good_config.yml')
  end

  def bad_config_path
    fixture('bad_config.yml')
  end

  def fixture(name)
    File.expand_path(name, FIXTURES_PATH)
  end
end
