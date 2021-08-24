feature 'So a user can login' do

  scenario 'the page should have a login form' do
    visit '/makersbnb'
    click_button('Login')
    expect(page).to have_content('Login to Makersbnb')
    expect(page).to have_field("email")
    expect(page).to have_field('password')
    expect(page).to have_button('Login')
  end
  
end