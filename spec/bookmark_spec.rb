require 'bookmark'

describe Bookmark do
  let(:bookmark) { described_class.new }
  let(:db_bookmark) { 'https://reddit.com' }
  let(:conn) { PG.connect(dbname: 'bookmarker_test') }
  let(:bookmarks) { described_class.all }

  describe '::all' do
    context 'when no bookmarks have been added' do
      it 'should return a message to the user' do
        allow(described_class).to receive(:retrieve_bookmarks).and_return('No bookmarks have been added yet.')
        expect(bookmarks).to eq('No bookmarks have been added yet.')
      end
      it 'should not return a bookmark' do
        allow(described_class).to receive(:retrieve_bookmarks).and_return('No bookmarks have been added yet.')
        expect(bookmarks).not_to include(db_bookmark)
      end
    end
    context 'when one bookmark has been added' do
      it 'should return the bookmark' do
        conn.exec("INSERT INTO bookmarks(url) VALUES('https://reddit.com');")
        expect(bookmarks).to include(db_bookmark)
      end
    end
  end

  describe '#create_bookmark' do
    it 'adds a new bookmark to the bookmark list' do
      bookmark.create_bookmark(db_bookmark)
      expect(bookmarks).to include(db_bookmark)
    end
  end
end
