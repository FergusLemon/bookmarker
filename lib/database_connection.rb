require 'pg'
class DatabaseConnection
  class << self
    def setup(database)
       @@database_connection = PG.connect(dbname: database)
    end

    def database_connection
      @@database_connection
    end
  end
end
