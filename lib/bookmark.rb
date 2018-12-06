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

    def delete(id)
      connection = choose_database_connection
      connection.exec("DELETE FROM bookmarks WHERE id='#{id}';")
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
      bookmarks_data = connection.exec('SELECT * FROM bookmarks')
      wrap_database_results(bookmarks_data)
    end

    def wrap_database_results(bookmarks_data)
      bookmarks_data.map do |bookmark|
        self.new(id: bookmark['id'], url: bookmark['url'], title: bookmark['title'])
      end
    end
  end
end
