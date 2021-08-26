require 'space'

describe Space do
  
  let(:user) { User.create(email: 'test1@test.com', password: 'test1') }
  let(:space) { described_class.new(1, "space1", "semi comfortable", 10000, 1) }
  let(:spaces) { Space.all }

  describe '#initialize' do
    it 'initializes with a name, description and price' do
      user
      expect(space).to have_attributes(id: 1, name: "space1", description: "semi comfortable", price: 10000, user_id: 1)
    end
  end

  describe '#self.all' do
    it 'list all spaces' do
      add_test_data
      expect(spaces).to include(Space)
      expect([spaces.first.id, spaces.last.id]).to eq(["1", "3"])
      expect([spaces.first.name, spaces.last.name]).to eq(['space1', 'space3'])
      expect([spaces.first.description, spaces.last.description]).to eq(['semi comfortable', 'uncomfortable'])
      expect([spaces.first.price, spaces.last.price]).to eq(["10000", "100000"])
    end
  end

  describe '#self.create' do
    it 'add space to database and create new space instance' do
      user
      new_space = Space.create('space1', 'semi comfortable', 10000, 1)
      expect(new_space).to be_a(Space)
      expect(new_space.name).to eq('space1')
      expect(new_space.description).to eq('semi comfortable')
      expect(new_space.price).to eq(10000)
    end
  end

  describe '#self.find' do
    it 'find space by id' do
      user
      new_space = Space.create('space1', 'semi comfortable', 10000, 1)
      result = Space.find(new_space.id)
      expect(result.name).to eq(new_space.name)
      expect(result.description).to eq(new_space.description)
      expect(result.price).to eq("#{new_space.price}")
    end
  end
end