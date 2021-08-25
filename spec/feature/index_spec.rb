
feature 'users can view the home page' do
  scenario 'expects user to see welcome to makersbnb' do
    visit '/makersbnb'
    expect(page).to have_content 'Welcome to Makersbnb!' 
  end

  scenario 'expect user to see sign up form' do
    visit '/makersbnb'
    expect(page).to have_field('email')
    expect(page).to have_field('password')
    expect(page).to have_field('password_confirmation')
    expect(page).to have_button('Sign up')
    expect(page).to have_button('Login')
    expect(page).to have_link('About')
  end

  scenario 'expect about link to take user to about page' do
    visit '/makersbnb'
    click_link('About')
    expect(page).to have_content("About us")
  end
end

feature "user can sign up for makers bnb" do
  scenario "user can create an account for the platform" do
    visit '/makersbnb'
    fill_in('email', with: 'test@test.com')
    fill_in('password', with: 'test')
    fill_in('password_confirmation', with: 'test')
    click_button('Sign up')
    expect(page).to have_content "Book A Space"
    expect(page).to have_button "Sign out"
  end
end


