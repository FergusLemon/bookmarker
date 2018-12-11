require 'tag'
require 'bookmark'
require 'bookmark_tag'
require_relative 'support/database_helpers'

describe Tag do
  let(:tag_class) { described_class }
  let(:bookmark_class) { double('Bookmark Clas') }
  let(:url) { 'https://github.com' }
  let(:title) { 'Github Homepage' }
  let(:other_url) { 'https://reddit.com' }
  let(:other_title) { 'Reddit Homepage' }
  let(:content) { 'Code' }
  let(:other_content) { 'Repository' }
  let!(:bookmark) { Bookmark.create(url, title) }
  let!(:bookmark_id) { Bookmark.all.to_a.first.id }
  let!(:another_bookmark) { Bookmark.create(other_url, other_title) }
  let!(:another_bookmark_id) { Bookmark.all.to_a.last.id }
  let!(:tag) { tag_class.create(content, bookmark_id) }
  let!(:tag_id) { tag_class.all.to_a.last.id }
  let!(:bookmark_tag) { BookmarkTag.create(bookmark_id: bookmark_id, tag_id: tag_id) }
  let!(:another_tag) { tag_class.create(other_content, bookmark_id) }
  let!(:another_tag_id) { tag_class.all.to_a.last.id }
  let!(:another_bookmark_tag) { BookmarkTag.create(bookmark_id: bookmark_id, tag_id: another_tag_id) }
  let(:tags) { persisted_data(table: 'tags', id: tag.id) }

  describe '::create' do
    it 'adds a tag to a bookmark' do
      expect(tags.first['content']).to eq(content)
    end
    context 'where a tag already exists' do
      it 'does not add a duplicate tag to the tags table' do
        expect { tag }.not_to change { tags.to_a.length }
        expect { tag_class.create(content, another_bookmark_id) }.not_to change\
          { tags.to_a.length }
      end
    end
  end

  describe '::all' do
    context 'when two tags exists' do
      it 'should not be empty' do
        expect(tag_class.all).not_to be_empty
      end
      it 'should include the tags' do
        expect(tag_class.all.last.id).to eq(another_tag.id)
      end
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

  describe '::bookmarks' do
    it 'returns all bookmarks associated with the tag' do
      tag_class.create(content, another_bookmark_id)
      expect(bookmark_class).to receive(:where).with(tag_id: tag_id)
      tag_class.bookmarks(bookmark_class, tag_id)
    end
  end
end
