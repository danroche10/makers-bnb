feature 'list all spaces' do
  scenario 'as a logged in user I can see all available spaces' do
    add_test_data
    login
    visit('/makersbnb/spaces')
    expect(page).to have_content('space1')
    expect(page).to have_content('very comfortable')
    expect(page).to have_content('100000')
  end

  scenario "as a logged in user I can't see booked spaces" do
    add_test_data
    login
    visit('/makersbnb/spaces')
    fill_in('start_date', with: "2021-08-26")
    fill_in('end_date', with: "2021-08-28")
    click_button('Filter Spaces by Date')
    expect(page).not_to have_content('space1')
  end
end