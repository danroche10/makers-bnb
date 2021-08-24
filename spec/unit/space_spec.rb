require 'space'

describe Space do

  let(:space) { described_class.new("space1", "semi comfortable", 10000, false)} 

  describe '#initialize' do
    it 'initializes with a name, description, price and booking status' do
      expect(space).to have_attributes(name: "space1", description: "semi comfortable", price: 10000, booked: false)
    end
  end

  describe'#all' do
    it 'list all spaces'
      expect(Space.all).to include(Space)
  end

end