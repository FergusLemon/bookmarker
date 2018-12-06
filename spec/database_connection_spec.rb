require 'database_connection'
describe DatabaseConnection do
  let(:db_class) { described_class }
  let(:database) { 'bookmarker' }
  let(:test_database) { 'bookmarker_test' }

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
end
