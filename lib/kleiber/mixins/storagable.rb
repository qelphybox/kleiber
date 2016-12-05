# encoding: utf-8

require 'gdbm'

module Kleiber
  # Module Storagable provides a storage method
  # @author Кирилл Бобыкин <qelphybox@gmail.com>
  module Storagable
    # Object for operations with storage
    # @return [Storage] storage object
    def storage
      @storage ||= Storage.new(storage_path)
    end

    def storage_path
      File.expand_path("#{name.demodulize.underscore.pluralize}.db", Kleiber.settings.storages_path)
    end

    # Class Storage provides api to storage file db
    # @author Кирилл Бобыкин <qelphybox@gmail.com>
    class Storage
      attr_reader :path
      def initialize(path)
        @path = path
      end

      # Writes to storage
      # @param [String] key
      # @param [String] value
      def write(key, value)
        transact { |db| db[key] = value }
      end

      # Reads from storage
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
end
