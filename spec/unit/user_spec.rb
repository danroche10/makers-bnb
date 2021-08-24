require 'user'

describe User do
  describe '.create' do
    it 'creates new user' do
      user = described_class.create(email: 'test@test.com', password: 'test')
      expect(user.id).not_to eq nil
      expect(user.email).to eq 'test@test.com'
      expect(user.password).to eq 'test'
    end
  end

  describe '.find' do
    it 'returns nil if no id is given' do
      expect(User.find(nil)).to eq nil
    end
    
    it 'finds user by id' do
      user = described_class.create(email: 'test@test.com', password: 'test')
      result = described_class.find(user.id)
      expect(result.email).to eq user.email
      expect(result.id).to eq user.id
      expect(result.password).to eq user.password
    end
  end

end

