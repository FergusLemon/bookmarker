require 'pg'
require_relative 'database_connection'
require 'bcrypt'
class User
  attr_reader :id, :username

  class << self
    def all
      retrieve_users
    end

    def create(username:, password:)
      hashed_password = BCrypt::Password.create(password)
      result = DatabaseConnection.query("INSERT INTO users(username, password)\
                                       VALUES('#{username}', '#{hashed_password}')\
                                       RETURNING id, username;")
      wrap_database_results(result).pop
    end

    def find(user_id:)
      return nil unless user_id
      result = DatabaseConnection.query("SELECT id, username FROM users WHERE\
                                        id = '#{user_id}';")
      wrap_database_results(result).pop
    end

    def authenticate(username:, password:)
      result = DatabaseConnection.query("SELECT id, username FROM users WHERE\
                                        username = '#{username}';")
      return nil unless result.any?
      user_data = DatabaseConnection.query("SELECT password FROM users WHERE\
                                          username = '#{username}';").to_a
      stored_hash = user_data.first['password']
      decrypted_password = BCrypt::Password.new(stored_hash)
      return nil unless decrypted_password == password
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
