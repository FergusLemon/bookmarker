require 'bookmark'

describe Bookmark do
  let(:id) { '1' }
  let(:url) { 'https://reddit.com' }
  let(:title) { 'Reddit Homepage' }
  let(:bookmark) { described_class.new(id: id, url: url, title: title) }
  let(:connection) { PG.connect(dbname: 'bookmarker_test') }
  let(:bookmark_class) { described_class }
  let(:bookmarks) { described_class.all }

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
        connection.exec("INSERT INTO bookmarks(url, title) VALUES('https://reddit.com', 'Reddit Homepage');")
        expect(bookmarks.last.url).to eq(bookmark.url)
      end
    end
  end

  describe '::create' do
    it 'should add a bookmark to the database table' do
      bookmark_class.create(url, title)
      expect(bookmarks.last.title).to eq(bookmark.title)
    end
  end

  describe '::delete' do
    it 'should delete a bookmark to the database table' do
      bookmark_class.create(url, title)
      bookmark_class.delete(id)
      expect(bookmarks).to be_empty
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
