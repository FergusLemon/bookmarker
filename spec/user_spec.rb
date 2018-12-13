require 'user'

describe User do
  let(:username) { 'test_user@gmail.com' }
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
    it "it hashes a user's password" do
      expect(BCrypt::Password).to receive(:create).with(password)
      User.create(username: username, password: password)
    end
  end

  describe '::authenticate' do
    it 'checks to see if the username provided matches that of an existing user' do
      User.create(username: username, password: password)
      user = User.authenticate(username: username, password: password)
      expect(user.username).to eq(username)
    end
    it 'returns nil if the username does not exist in the database' do
      expect(User.authenticate(username: username, password: password)).to eq nil
    end
    it 'returns nil if the username exists but the password is incorrect' do
      User.create(username: username, password: password)
      expect(User.authenticate(username: username, password: 'random')).to eq nil
    end
  end

  describe '::find' do
    it 'searches a db for a user based on a user ID' do
      user = User.create(username: username, password: password)
      returned_user = User.find(user_id: user.id)
      expect(returned_user.username).to eq(username)
    end
    it 'returns nil if there is no user_id stored in a session' do
      expect(User.find(user_id: nil)).to eq(nil)
    end
  end
end
