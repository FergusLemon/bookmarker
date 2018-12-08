require File.join(File.dirname(__FILE__), '..', '..', 'lib', 'database_connection')

def persisted_data(table:, id:)
  DatabaseConnection.query("SELECT * FROM #{table} WHERE id = #{id};")
end
