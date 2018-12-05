require 'bookmark'

describe Bookmark do
  let(:url) { 'https://reddit.com' }
  let(:title) { 'Reddit Homepage' }
  let(:bookmark) { described_class.new(url, title) }
  let(:connection) { PG.connect(dbname: 'bookmarker_test') }
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

  describe '#initialize' do
    it 'adds a new bookmark to the bookmark list' do
      described_class.new('test_url', 'test_title')
      expect(bookmarks).to include('test_url')
    end
  end
end
