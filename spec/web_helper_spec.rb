

def new_user_login
  user = User.create(email: 'test@test.com', password: 'test')
  visit '/makersbnb'
  click_button('Login')
end

def log_in_details
  fill_in('email', with: 'test@test.com')
  fill_in('password', with: 'test')
  click_button('Login')
end

def login
  new_user_login
  log_in_details
end

def login_space_owner
  visit '/makersbnb'
  click_button('Login')
  fill_in('email', with: 'test2@test.com')
  fill_in('password', with: 'test2')
  click_button('Login')
end