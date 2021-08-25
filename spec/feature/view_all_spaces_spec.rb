feature 'list all spaces' do
  scenario 'as a logged in user I can see all available spaces' do
    add_test_spaces
    visit('/makersbnb/spaces')
    expect(page).to have_content('space1')
    expect(page).to have_content('very comfortable')
    expect(page).to have_content('100000')
  end

  xscenario "as a logged in user I can't see booked spaces" do
    add_test_spaces
    # Space.book(1)
    visit('/makersbnb/spaces')
    expect(page).not_to have_content('space1')
  end
end