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

  private

  class << self
    def retrieve_bookmarks
      conn = PG.connect(dbname: 'bookmarker')
      result = conn.exec('SELECT * FROM bookmarks')
      rows = result.map { |row| row.values_at('url') }.flatten
      rows.size.zero? ? 'No bookmarks have been added yet.' : rows
    end
  end
end
