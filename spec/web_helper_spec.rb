def new_user_login
  user = User.create(email: 'test@test.com', password: 'test')
  visit '/makersbnb'
  click_button('Login')
end