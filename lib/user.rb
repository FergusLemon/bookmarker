require 'pg'
require_relative 'database_connection'
class User
attr_reader :id, :username

  class << self
    def all
      retrieve_users
    end

    def create(username:, password:)
      hashed_password = password
      result = DatabaseConnection.query("INSERT INTO users(username, password)\
                                       VALUES('#{username}', '#{hashed_password}')\
                                       RETURNING id, username;")
      wrap_database_results(result).pop
    end
  end

  def initialize(**args)
    @id = args[:id]
    @username = args[:username]
  end

  private

  class << self
    def retrieve_users
      user_data = DatabaseConnection.query('SELECT * FROM users;')
      wrap_database_results(user_data)
    end

    def wrap_database_results(user_data)
      user_data.map do |user|
        self.new(id: user['id'],\
                 username: user['username'])
      end
    end
  end
end
