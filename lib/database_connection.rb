require 'pg'
class DatabaseConnection
  class << self
    def setup(database)
       @@database_connection = PG.connect(dbname: database)
    end

    def query(query_string)
      @@database_connection.exec(query_string)
    end

    def database_connection
      @@database_connection
    end
  end
end
