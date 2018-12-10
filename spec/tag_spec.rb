require 'tag'
require 'bookmark'
require_relative 'support/database_helpers'

describe Tag do
  let(:tag_class) { described_class }
  let(:url) { 'https://github.com' }
  let(:title) { 'Github Homepage' }
  let(:content) { 'Code' }

  describe '::create' do
    it 'adds a tag to a bookmark' do
      Bookmark.create(url, title)
      bookmark_id = Bookmark.all.to_a.last.id
      tag = tag_class.create(content, bookmark_id)
      tags = persisted_data(table: 'tags', id: tag.id)
      expect(tags.first['content']).to eq(content)
    end
  end
end
