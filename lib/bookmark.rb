class Bookmark

  class << self
    attr_reader :bookmarks
    @@bookmarks = []

    def all
      @@bookmarks.empty? ? 'No bookmarks have been added yet.' : @@bookmarks
    end
  end

  def initialize
    @@bookmarks << self
  end
end
