require 'pg'
class Bookmark

  class << self
    attr_reader :bookmarks
    @@bookmarks = []

    def all
      retrieve_bookmarks
    end
  end

  def initialize
    @@bookmarks << self
  end

  def create_bookmark(url)
    if ENV['RACK_ENV'] == 'test'
      conn = PG.connect(dbname: 'bookmarker_test')
    else
      conn = PG.connect(dbname: 'bookmarker')
    end
    conn.exec("INSERT INTO bookmarks(url) VALUES('#{url}');")
  end
  private

  class << self
    def retrieve_bookmarks
      if ENV['RACK_ENV'] == 'test'
        conn = PG.connect(dbname: 'bookmarker_test')
      else
        conn = PG.connect(dbname: 'bookmarker')
      end
      result = conn.exec('SELECT * FROM bookmarks')
      rows = result.map { |row| row.values_at('url') }.flatten
      rows.size.zero? ? 'No bookmarks have been added yet.' : rows
    end
  end
end
