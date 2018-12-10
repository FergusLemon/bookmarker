class Tag
attr_reader :id, :content

  class << self
    def create(content, bookmark_id)
      result = DatabaseConnection.query("INSERT INTO tags(content)\
                                        VALUES('#{content}')\
                                        RETURNING id, content;")
      DatabaseConnection.query("INSERT INTO bookmark_tags(bookmark_id, tag_id)\
                               VALUES('#{bookmark_id}', '#{result[0]['id']}');")
      wrap_database_results(result).pop
    end
  end

  def initialize(**args)
    @id = args[:id]
    @content = args[:content]
  end

  private

  class << self
    def wrap_database_results(table_data)
      table_data.map do |row|
        self.new(id: row['id'],\
                 content: row['content'])
      end
    end
  end
end
