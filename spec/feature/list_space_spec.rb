feature 'list a space to rent' do
  scenario 'as a logged in user I want to list a space' do
    login
    visit('/makersbnb/spaces')
    click_button('List a Space')
    fill_in('name', with: 'space4')
    fill_in('description', with: 'description')
    fill_in('price', with: '5')
    click_button('List my Space')
    expect(page).to have_content('space4')
  end
end