feature 'list all spaces' do
  scenario 'as a logged in user I can see all available spaces' do
    add_test_spaces
    visit('/makersbnb/spaces')
    expect(page).to have_content('space1')
    expect(page).to have_content('very comfortable')
    expect(page).to have_content('100000')
  end
end