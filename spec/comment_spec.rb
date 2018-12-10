require 'comment'
require 'bookmark'
require_relative 'support/database_helpers'

describe Comment do
  let(:comment_class) { described_class }
  let(:text) { 'Test comment' }
  let(:more_text) { 'Another Test comment' }
  let(:url) { 'https://github.com' }
  let(:title) { 'Github Homepage' }

  describe '::create' do
    it 'should add a comment to the comments table' do
      Bookmark.create(url, title)
      bookmark_id = Bookmark.all.to_a.last.id
      comment = comment_class.create(text, bookmark_id)
      comments = persisted_data(table: 'comments', id: comment.id)
      expect(comments.first['bookmark_id']).to eq(bookmark_id)
      expect(comments.first['text']).to eq(text)
    end
  end

  describe '::where' do
    it 'returns all comments made on a bookmark' do
      Bookmark.create(url, title)
      bookmark_id = Bookmark.all.to_a.last.id
      comment_class.create(text, bookmark_id)
      comment_class.create(more_text, bookmark_id)
      comments = comment_class.where(bookmark_id)
      expect(comments.size).to eq(2)
      expect(comments.first.text).to eq(text)
      expect(comments.last.text).to eq(more_text)
    end
  end
end
