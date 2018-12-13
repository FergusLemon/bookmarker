require 'pg'
require_relative 'database_connection'
class Bookmark
attr_reader :id, :url, :title

  class << self
    def all
      retrieve_bookmarks
    end

    def comments(comment_class = Comment, id)
      retrieve_comments(comment_class, id)
    end

    def tags(tag_class = Tag, id)
      retrieve_tags(tag_class, id)
    end

    def where(tag_id)
      result = DatabaseConnection.query("SELECT bookmarks.id, url, title FROM\
                                        bookmarks INNER JOIN bookmark_tags ON\
                                        bookmarks.id = bookmark_tags.bookmark_id\
                                        WHERE bookmark_tags.tag_id = #{tag_id};")
      wrap_database_results(result)
    end

    def create(url, title)
       result = DatabaseConnection.query("INSERT INTO bookmarks(url, title)\
                                         VALUES('#{url}', '#{title}')\
                                         RETURNING id, url, title;")
       wrap_database_results(result).pop
    end

    def delete(id)
      DatabaseConnection.query("DELETE FROM bookmarks WHERE id='#{id}';")
    end

    def update(id, url, title)
      DatabaseConnection.query("UPDATE bookmarks SET url='#{url}',\
                               title='#{title}' WHERE id='#{id}';")
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
      bookmarks_data = DatabaseConnection.query('SELECT * FROM bookmarks;')
      wrap_database_results(bookmarks_data)
    end

    def retrieve_comments(comment_class, id)
      comment_class.where(bookmark_id: id)
    end

    def retrieve_tags(tag_class, id)
      tag_class.where(bookmark_id: id)
    end

    def wrap_database_results(bookmarks_data)
      bookmarks_data.map do |bookmark|
        self.new(id: bookmark['id'],\
                 url: bookmark['url'],\
                 title: bookmark['title'])
      end
    end
  end
end
