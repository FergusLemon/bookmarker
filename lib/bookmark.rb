class Bookmark

  @@bookmarks = []

  def initialize
    @@bookmarks << self
  end

  class << self
    def all
      @@bookmarks unless @@bookmarks.empty?
      'No bookmarks have been added yet.'
    end
  end
end
