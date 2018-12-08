class Comment
attr_reader :id, :text, :bookmark_id

  class << self
    def create(comment, bookmark_id)
      result = DatabaseConnection.query("INSERT INTO comments(text, bookmark_id) VALUES('#{comment}', '#{bookmark_id}') RETURNING id, text, bookmark_id;")
      self.new(id: result[0]['id'], text: result[0]['text'], bookmark_id: result[0]['bookmark_id'])
    end
  end

  def initialize(**args)
    @id = args[:id]
    @text = args[:text]
    @bookmark_id = args[:bookmark_id]
  end
end
