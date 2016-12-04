# encoding: utf-8

require 'gdbm'

module DBSpecHelper
  def db_read(key)
    GDBM.open(db_path) do |db|
      db[key]
    end
  end

  def db_write(key, value)
    GDBM.open(db_path) do |db|
      db[key] = value
    end
  end
end
