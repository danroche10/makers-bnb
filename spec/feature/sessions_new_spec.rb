feature 'So a user can login' do

  scenario 'the page should have a login form' do
    visit '/makersbnb'
    click_button('Login')
    expect(page).to have_button('Sign up')
    expect(page).to have_content('Login to Makersbnb')
    expect(page).to have_field("email")
    expect(page).to have_field('password')
    expect(page).to have_button('Login')
  end

  scenario 'user enters correct details' do
    new_user_login
    fill_in('email', with: 'test@test.com')
    fill_in('password', with: 'test')
    click_button('Login')
    expect(page).to have_content("Book a space")
  end

  scenario 'user enters incorrect email' do
    new_user_login
    fill_in('email', with: 'wrongemail@test.com')
    fill_in('password', with: 'test')
    click_button('Login')
    expect(page).not_to have_content("Book a space")
  end

  scenario 'user enters incorrect email' do
    new_user_login
    fill_in('email', with: 'test@test.com' )
    fill_in('password', with: 'wrongpassword')
    click_button('Login')
    expect(page).not_to have_content("Book a space")
  end
  
end