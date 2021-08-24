require 'user'

describe User do

  let(:user) { described_class.create(email: 'test@test.com', password: 'test') }


  describe '#initialize' do
    it 'initializes with an id, email, password' do
      expect(user).to have_attributes(id: '1', email: 'test@test.com', password: 'test')
    end
  end

  describe '.create' do
    it 'creates new user' do
      expect(user.id).to eq '1'
      expect(user.email).to eq 'test@test.com'
      expect(user.password).to eq 'test'
    end
  end

  describe '.find' do
    it 'returns nil if no id is given' do
      expect(User.find(nil)).to eq nil
    end
    
    it 'finds user by id' do
      result = described_class.find(user.id)
      expect(result.email).to eq user.email
      expect(result.id).to eq user.id
      expect(result.password).to eq user.password
    end
  end

  describe '.authenticate' do
    it 'returns a user given a correct username and password, if one exists' do
      user = described_class.create(email: 'test@test.com', password: 'test')
      authenticated_user = described_class.authenticate(email: 'test@test.com', password: 'test')

      expect(authenticated_user.id).to eq user.id
    end

    it 'returns nil given an incorrect email address' do
      expect(User.authenticate(email: 'nottherightemail@me.com', password: 'password123')).to be_nil
    end

    it 'returns nil given an incorrect password' do
      expect(User.authenticate(email: 'test@test.com', password: 'wrongpassword')).to be_nil
    end
  end

end

