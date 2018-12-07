require_relative 'database_connection'
if RACK_ENV = 'test'
  DatabaseConnection.setup('bookmarker_test')
else
  DatabaseConnection.setup('bookmarker')
end
