# encoding: utf-8

require 'gdbm'

module Kleiber
  # Class Store provides api to store file db
  # @author Кирилл Бобыкин <qelphybox@gmail.com>
  class Store
    attr_reader :path
    def initialize(path)
      @path = path
    end

    # Writes to store
    # @param [String] key
    # @param [String] value
    def write(key, value)
      transact { |db| db[key] = value }
    end

    # Reads from store
    # @param [String] key
    def read(key)
      transact { |db| db[key] }
    end

    # Provides block for transaction
    # @yieldparam [GDBM] db file database dao
    def transact
      GDBM.open(path) do |db|
        yield db
      end
    end
  end
end
