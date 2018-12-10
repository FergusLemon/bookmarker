require 'tag'
require 'bookmark'
require_relative 'support/database_helpers'

describe Tag do
  let(:tag_class) { described_class }
  let(:url) { 'https://github.com' }
  let(:title) { 'Github Homepage' }
  let(:content) { 'Code' }
  let(:other_content) { 'Repository' }
  let!(:bookmark) { Bookmark.create(url, title) }
  let!(:bookmark_id) { Bookmark.all.to_a.last.id }
  let!(:tag) { tag_class.create(content, bookmark_id) }
  let!(:another_tag) { tag_class.create(other_content, bookmark_id) }
  let(:tags) { persisted_data(table: 'tags', id: tag.id) }
  let(:join) { join_data(table: 'bookmark_tags', tag_id: tag.id) }

  describe '::create' do
    it 'adds a tag to a bookmark' do
      expect(tags.first['content']).to eq(content)
    end
    it 'adds an entry in the join table' do
      expect(join.first['bookmark_id']).to eq(bookmark_id)
    end
  end

  describe '::where' do
    it 'returns all tags added to a bookmark' do
      tags = tag_class.where(bookmark_id)
      expect(tags.length).to eq(2)
      expect(tags.first.content).to eq(content)
      expect(tags.last.content).to eq(other_content)
    end
  end
end
