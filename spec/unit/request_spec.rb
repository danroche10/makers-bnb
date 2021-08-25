require 'request'
require 'user'
require 'space'

describe Request do

  let(:request) { described_class.new(id: 1, start_date: '2021-09-01', end_date: '2021-09-5',  user_id: 1, space_id: 1, approval_status: nil) }
  let(:my_request) { described_class.create(start_date: '2021-09-01', end_date: '2021-09-5',  user_id: user.id, space_id: space.id, approval_status: request.approval_status)     }
  let(:user) { User.create(email: 'test@test.com', password: 'test') }
  let(:space) { Space.create("space1", "semi comfortable", 10000) }

  describe '#initialize' do
    it 'initializes with a start date, end date, user_id and space_id' do
      expect(request).to have_attributes(id: 1, start_date: '2021-09-01', end_date: '2021-09-5',  user_id: 1, space_id: 1, approval_status: nil)
    end
  end

  describe '#create' do
    it 'creates new request for user' do
      expect(my_request.start_date).to eq '2021-09-01'
    end
  end

  describe '#all' do
    it 'returns all requests for user' do
      my_request
      expect(Request.all(1)[0].id).to eq '1'
    end
  end








end