require 'user'

describe User do
let(:username) { 'TestUser' }
let(:password) { 'Te$tPa$$word' }
let(:connection) { PG.connect(dbname: 'bookmarker_test') }
let(:users) { User.all }

  describe '::all' do
    context 'when no users have been registered' do
      it 'should be empty' do
        expect(users).to be_empty
      end
    end
    context 'when one user has been registered' do
      it 'should include the user' do
        User.create(username: username, password: password)
        expect(users.last.username).to eq(username)
      end
    end
  end

  describe '::create' do
    it 'creates a new user' do
      User.create(username: username, password: password)
      expect(users).not_to be_empty
      expect(users.length).to eq(1)
    end
  end
end
