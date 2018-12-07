require 'database_connection'
describe DatabaseConnection do
  let(:db_class) { described_class }
  let(:database) { 'bookmarker' }
  let(:test_database) { 'bookmarker_test' }
  let(:create_entry) { "INSERT INTO bookmarks(url, title) VALUES('https://google.com', 'Google Homepage');" }
  let(:read_entry) { "SELECT * FROM bookmarks;" }
  let(:delete_entry) { "DELETE FROM bookmarks WHERE url='https://google.com';" }
  let(:update_entry) { "UPDATE bookmarks SET url='https://reddit.com' WHERE url='https://google.com';" }

  describe '::setup' do
    it 'sets up a connection to the database passed to it' do
      expect(PG).to receive(:connect).with(dbname: database)
      db_class.setup(database)
    end
    it 'sets up a connection to the test database passed to it' do
      expect(PG).to receive(:connect).with(dbname: test_database)
      db_class.setup(test_database)
    end
    it 'stores the connection in @@database' do
      connection = db_class.setup(database)
      expect(db_class.database_connection).to eq(connection)
    end
  end

  describe '::query' do
    it 'creates new entries in the database table' do
      connection = db_class.setup(test_database)
      expect(connection).to receive(:exec).with(create_entry)
      db_class.query(create_entry)
    end
    it 'retrieves entries from the database table' do
      db_class.setup(test_database)
      db_class.query(create_entry)
      result = db_class.query(read_entry)
      expect(result[0]['url']).to eq('https://google.com')
    end
    it 'deletes an entry from the database' do
      db_class.setup(test_database)
      db_class.query(create_entry)
      db_class.query(delete_entry)
      result = db_class.query(read_entry)
      expect(result.to_a).to be_empty
    end
    it 'edits an existing bookmark' do
      db_class.setup(test_database)
      db_class.query(create_entry)
      db_class.query(update_entry)
      result = db_class.query(read_entry)
      expect(result[0]['url']).to eq('https://reddit.com')
    end
  end
end
