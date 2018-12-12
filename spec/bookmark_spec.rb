require 'bookmark'

describe Bookmark do
  let(:id) { '1' }
  let(:url) { 'https://reddit.com' }
  let(:title) { 'Reddit Homepage' }
  let(:new_url) { 'https://google.com' }
  let(:new_title) { 'Google Homepage' }
  let(:another_url) { 'https:://github.com' }
  let(:another_title) { 'Github Homepage' }
  let(:bookmark) { described_class.new(id: id, url: url, title: title) }
  let(:connection) { PG.connect(dbname: 'bookmarker_test') }
  let(:bookmark_class) { described_class }
  let(:bookmarks) { described_class.all }
  let(:comment_class) { double('Comment Class') }
  let(:tag_class) { double('Tag Class') }
  let(:tag_id) { 1 }

  describe '::all' do
    context 'when no bookmarks have been added' do
      it 'should be empty' do
        expect(bookmarks).to be_empty
      end
      it 'should not return a bookmark' do
        expect(bookmarks).not_to include(bookmark)
      end
    end
    context 'when one bookmark has been added' do
      it 'should include the bookmark' do
        connection.exec("INSERT INTO bookmarks(url, title)\
                        VALUES('https://reddit.com', 'Reddit Homepage');")
        expect(bookmarks.last.url).to eq(bookmark.url)
      end
    end
  end

  describe '::comments' do
    it 'returns all comments made on a bookmark' do
      bookmark_class.create(url, title)
      id = bookmarks.last.id
      expect(comment_class).to receive(:where).with(bookmark_id: id)
      bookmark_class.comments(comment_class, id)
    end
  end

  describe '::tags' do
    it 'returns all tags added to a bookmark' do
      bookmark_class.create(url, title)
      id = bookmarks.last.id
      expect(tag_class).to receive(:where).with(bookmark_id: id)
      bookmark_class.tags(tag_class, id)
    end
  end

  describe '::where' do
    it 'returns all bookmarks associated with a tag' do
      bookmark = bookmark_class.create(url, title)
      tag1 = Tag.create('Test1', bookmark.id)
      BookmarkTag.create(bookmark_id: bookmark.id, tag_id: tag1.id)
      tag2 = Tag.create('Test2', bookmark.id)
      BookmarkTag.create(bookmark_id: bookmark.id, tag_id: tag2.id)
      another_bookmark = bookmark_class.create(another_url, another_title)
      tag3 = Tag.create('Test1', another_bookmark.id)
      BookmarkTag.create(bookmark_id: another_bookmark.id, tag_id: tag3.id)
      result = bookmark_class.where(tag1.id)
      expect(result.length).to eq(2)
      expect(result.first.title).to eq(title)
      expect(result.last.title).to eq(another_title)
    end
  end

  describe '::create' do
    it 'should add a bookmark to the database table' do
      bookmark_class.create(url, title)
      expect(bookmarks.last.title).to eq(bookmark.title)
    end
  end

  describe '::delete' do
    it 'should delete a bookmark from the database table' do
      bookmark_class.create(url, title)
      bookmark_class.delete(id)
      expect(bookmarks).to be_empty
    end
  end

  describe '::update' do
    it 'should update an existing bookmark' do
      bookmark_class.create(url, title)
      bookmark_class.update(id, new_url, new_title)
      expect(bookmarks.first.url).to eq(new_url)
      expect(bookmarks.first.title).to eq(new_title)
    end
  end

  describe '#id' do
    it 'should return the id of the bookmark' do
      expect(bookmark.id).to eq(id)
    end
  end

  describe '#url' do
    it 'should return the url of the bookmark' do
      expect(bookmark.url).to eq(url)
    end
  end

  describe '#title' do
    it 'should return the title of the bookmark' do
      expect(bookmark.title).to eq(title)
    end
  end
end
