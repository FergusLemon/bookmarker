require 'bookmark_tag'

describe BookmarkTag do
  let(:bookmark_tag_class) { described_class }
  let(:bookmark_tags) {described_class.all}

  describe '::create' do
    it 'adds an entry in the bookmark_tags join table' do
      Bookmark.create('https://github.com', 'Github Homepage')
      bookmark_id = Bookmark.all.to_a.first.id
      Tag.create('Tag number 1', bookmark_id)
      tag_id = Tag.all.to_a.first.id
      bookmark_tag_class.create(bookmark_id: bookmark_id, tag_id: tag_id)
      expect(bookmark_tags.first.bookmark_id).to eq(bookmark_id)
      expect(bookmark_tags.last.tag_id).to eq(tag_id)
    end
  end
end
