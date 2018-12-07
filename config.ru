require File.join(File.dirname(__FILE__), 'app.rb')

run Bookmarker
if RACK_ENV = 'test'
  DatabaseConnection.setup('bookmarker_test')
else
  DatabaseConnection.setup('bookmarker')
end
