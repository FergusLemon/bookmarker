require 'bookmark'

describe Bookmark do
  let(:id) { '1' }
  let(:url) { 'https://reddit.com' }
  let(:title) { 'Reddit Homepage' }
  let(:new_url) { 'https://google.com' }
  let(:new_title) { 'Google Homepage' }
  let(:bookmark) { described_class.new(id: id, url: url, title: title) }
  let(:connection) { PG.connect(dbname: 'bookmarker_test') }
  let(:bookmark_class) { described_class }
  let(:bookmarks) { described_class.all }
  let(:comment_class) { double('Comment Class') }

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
