# encoding: utf-8

module SymphonySpecHelper
  def projects_stub
    Array.new(rand(1..10)) { |i| "project#{i}" }
  end
end
