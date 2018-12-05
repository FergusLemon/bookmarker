require 'pg'
class Bookmark

  class << self
    def all
      retrieve_bookmarks
    end
  end

  def initialize(url)
    if ENV['RACK_ENV'] == 'test'
      connection = PG.connect(dbname: 'bookmarker_test')
    else
      connection = PG.connect(dbname: 'bookmarker')
    end
    connection.exec("INSERT INTO bookmarks(url) VALUES('#{url}');")
  end

  private

  class << self
    def retrieve_bookmarks
      if ENV['RACK_ENV'] == 'test'
        connection = PG.connect(dbname: 'bookmarker_test')
      else
        connection = PG.connect(dbname: 'bookmarker')
      end
      result = connection.exec('SELECT * FROM bookmarks')
      rows = result.map { |row| row.values_at('url') }.flatten
    end
  end
end
