require 'pg'
class Bookmark
attr_reader :id, :url, :title

  class << self
    def all
      retrieve_bookmarks
    end

    def create(url, title)
      connection = choose_database_connection
      connection.exec("INSERT INTO bookmarks(url, title) VALUES('#{url}', '#{title}');")
    end
  end

  def initialize(**args)
    @id = args[:id]
    @url = args[:url]
    @title = args[:title]
  end

  private

  class << self
    def choose_database_connection
      if ENV['RACK_ENV'] == 'test'
        PG.connect(dbname: 'bookmarker_test')
      else
        PG.connect(dbname: 'bookmarker')
      end
    end

    def retrieve_bookmarks
      connection = choose_database_connection
      result = connection.exec('SELECT * FROM bookmarks')
      result.map { |row| row.values_at('url') }.flatten
    end
  end
end
