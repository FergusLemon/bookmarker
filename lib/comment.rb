class Comment
attr_reader :id, :text, :bookmark_id

  class << self
    def create(comment, bookmark_id)
      result = DatabaseConnection.query("INSERT INTO comments(text, bookmark_id)\
                                        VALUES('#{comment}', '#{bookmark_id}')\
                                        RETURNING id, text, bookmark_id;")
      wrap_database_results(result).pop
    end

    def where(bookmark_id)
      result = DatabaseConnection.query("SELECT * FROM comments WHERE\
                                         bookmark_id='#{bookmark_id}';")
      wrap_database_results(result)
    end
  end

  def initialize(**args)
    @id = args[:id]
    @text = args[:text]
    @bookmark_id = args[:bookmark_id]
  end

  private

  class << self
    def wrap_database_results(table_data)
      table_data.map do |row|
        self.new(id: row['id'],\
                 text: row['text'],\
                 bookmark_id: row['bookmark_id'])
      end
    end
  end
end
