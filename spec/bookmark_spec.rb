require 'bookmark'

describe Bookmark do
  let(:url) { 'https://reddit.com' }
  let(:title) { 'Reddit Homepage' }
  let(:bookmark) { described_class.new(url, title) }
  let(:connection) { PG.connect(dbname: 'bookmarker_test') }
  let(:bookmark_class) { described_class }
  let(:bookmarks) { described_class.all }

  describe '::all' do
    context 'when no bookmarks have been added' do
      it 'should be empty' do
        expect(bookmarks).to be_empty
      end
      it 'should not return a bookmark' do
        expect(bookmarks).not_to include(url)
      end
    end
    context 'when one bookmark has been added' do
      it 'should return the bookmark' do
        connection.exec("INSERT INTO bookmarks(url, title) VALUES('https://reddit.com', 'Reddit Homepage');")
        expect(bookmarks).to include(url)
      end
    end
  end

  describe '::create' do
    it 'should add a bookmark to the database table' do
      bookmark_class.create(url, title)
      expect(bookmarks).to include(url)
    end
  end
end
