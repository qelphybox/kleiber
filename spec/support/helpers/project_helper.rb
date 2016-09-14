# encoding: utf-8

module ProjectSpecHelper
  def config_stub
    Array.new(rand(1..10)) { |i| "project#{i}" }
  end
end
