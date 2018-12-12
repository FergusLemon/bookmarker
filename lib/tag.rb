class Tag
attr_reader :id, :content

  class << self
    def create(content, bookmark_id)
      tag_exists = DatabaseConnection.query("SELECT id FROM tags WHERE\
                                            tags.content = '#{content}';").first
      if !tag_exists
        result = DatabaseConnection.query("INSERT INTO tags(content)\
                                          VALUES('#{content}')\
                                          RETURNING id, content;")
        wrap_database_results(result).pop
      else
        self.all.select { |tag| tag.id == tag_exists['id'] }.pop
      end
    end

    def where(bookmark_id)
      result = DatabaseConnection.query("SELECT tags.id, content FROM tags\
                                        INNER JOIN bookmark_tags ON\
                                        tags.id = bookmark_tags.tag_id WHERE\
                                        bookmark_tags.bookmark_id = '#{bookmark_id}';")
      wrap_database_results(result)
    end

    def all
      retrieve_tags
    end

    def bookmarks(bookmark_class = Bookmark, id)
      retrieve_bookmarks(bookmark_class, id)
    end
  end

  def initialize(**args)
    @id = args[:id]
    @content = args[:content]
  end

  private

  class << self
    def retrieve_tags
      tags_data = DatabaseConnection.query('SELECT * FROM tags')
      wrap_database_results(tags_data)
    end

    def retrieve_bookmarks(bookmark_class, id)
      bookmark_class.where(tag_id: id)
    end

    def wrap_database_results(table_data)
        table_data.map do |row|
          self.new(id: row['id'],\
                 content: row['content'])
      end
    end
  end
end
