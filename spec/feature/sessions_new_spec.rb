feature 'So a user can login' do

  scenario 'the page should have a login form' do
    visit '/makersbnb'
    click_button('Login')
    expect(page).to have_button('Sign up')
    expect(page).to have_content('Login to MakersBnB')
    expect(page).to have_field("email")
    expect(page).to have_field('password')
    expect(page).to have_button('Login')
  end

  scenario 'user enters correct details' do
    new_user_login
    log_in_details
    expect(page).to have_content("Book a Space")
  end

  scenario 'user enters incorrect email' do
    new_user_login
    fill_in('email', with: 'wrongemail@test.com')
    fill_in('password', with: 'test')
    click_button('Login')
    expect(page).not_to have_content("Book a Space")
    expect(page).to have_content("You have entered incorrect details")
  end

  scenario 'user enters incorrect password' do
    new_user_login
    fill_in('email', with: 'test@test.com' )
    fill_in('password', with: 'wrongpassword')
    click_button('Login')
    expect(page).not_to have_content("Book a Space")
    expect(page).to have_content "You have entered incorrect details"
  end  
end

feature "once logged in, user should be able to log out" do
  scenario "by clicking on the Log out button" do
    new_user_login
    log_in_details
    expect(page).to have_button("Log out")
    click_button('Log out')
    expect(page).to have_button 'Login'
  end
    scenario "if logged in, the about us page should allow to Log out" do
      new_user_login
      log_in_details
      expect(page).to have_button("Log out")
      click_button('Log out')
      expect(page).to have_button 'Login'
    end
end

