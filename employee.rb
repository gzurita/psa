require 'dm-core'
require 'dm-migrations'
require 'dm-serializer'

DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/development.db")

class Employee
  include DataMapper::Resource
  property :id, Serial
  property :first_name, String
  property :last_name, String
end

DataMapper.finalize
DataMapper.auto_migrate!