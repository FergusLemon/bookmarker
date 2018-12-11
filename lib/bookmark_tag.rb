class BookmarkTag
attr_reader :bookmark_id, :tag_id

  class << self
    def create(bookmark_id:, tag_id:)
      result = DatabaseConnection.query("INSERT INTO bookmark_tags\
                                        (bookmark_id, tag_id)\
                                        VALUES('#{bookmark_id}', '#{tag_id}');")
      wrap_database_results(result).pop
    end

    def all
      retrieve_bookmark_tags
    end
  end

  def initialize(**args)
    @bookmark_id = args[:bookmark_id]
    @tag_id = args[:tag_id]
  end

  private

  class << self
    def wrap_database_results(table_data)
      table_data.map do |row|
        self.new(bookmark_id: row['bookmark_id'], tag_id: row['tag_id'])
      end
    end

    def retrieve_bookmark_tags
      bookmark_tags_data = DatabaseConnection.query('SELECT * FROM bookmark_tags')
      wrap_database_results(bookmark_tags_data)
    end
  end
end
