require 'pg'
require_relative 'database_connection'
class Bookmark
attr_reader :id, :url, :title

  class << self
    def all
      retrieve_bookmarks
    end

    def comments(id)
      retrieve_comments(id)
    end

    def create(url, title)
      DatabaseConnection.query("INSERT INTO bookmarks(url, title) VALUES('#{url}', '#{title}');")
    end

    def delete(id)
      DatabaseConnection.query("DELETE FROM bookmarks WHERE id='#{id}';")
    end

    def update(id, url, title)
      DatabaseConnection.query("UPDATE bookmarks SET url='#{url}', title='#{title}' WHERE id='#{id}';")
    end
  end

  def initialize(**args)
    @id = args[:id]
    @url = args[:url]
    @title = args[:title]
  end

  private

  class << self
    def retrieve_bookmarks
      bookmarks_data = DatabaseConnection.query('SELECT * FROM bookmarks')
      wrap_database_results(bookmarks_data)
    end

    def retrieve_comments(id)
      DatabaseConnection.query("SELECT * FROM comments WHERE bookmark_id='#{id}';")
    end

    def wrap_database_results(bookmarks_data)
      bookmarks_data.map do |bookmark|
        self.new(id: bookmark['id'], url: bookmark['url'], title: bookmark['title'])
      end
    end
  end
end
