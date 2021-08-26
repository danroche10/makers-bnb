require_relative '../lib/request'
require_relative '../lib/user'
require_relative '../lib/space'

def add_test_users
  User.create(email: 'test1@test.com', password: 'test1')
  User.create(email: 'test2@test.com', password: 'test2')
  User.create(email: 'test3@test.com', password: 'test3')
 end


def add_test_spaces
  Space.create('space1', 'semi comfortable', 10000)
  Space.create('space2', 'very comfortable', 10)
  Space.create('space3', 'uncomfortable', 100000)
end

def add_test_requests
  Request.create(start_date: '2021-09-01', end_date: '2021-09-5',  user_id: 1, space_id: 1, approval_status: nil)
  Request.create(start_date: '2021-09-02', end_date: '2021-09-6',  user_id: 1, space_id: 1, approval_status: nil)
  Request.create(start_date: '2021-09-03', end_date: '2021-09-7',  user_id: 1, space_id: 1, approval_status: nil)
end

def add_test_data
  add_test_users
  add_test_spaces
  add_test_requests
end
