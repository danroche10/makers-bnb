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
end