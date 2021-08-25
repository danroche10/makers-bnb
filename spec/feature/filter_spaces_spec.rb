feature 'filter spaces' do
  xscenario 'enter dates and see available spaces' do
    add_test_spaces
    # add_test_requests
    visit('/makersbnb/space')
    fill_in("start_date", with: '2021-08-25')
    fill_in("end_date", with: '2021-09-01')
    click_button('Filter Spaces by Date')
    expect(page).not_to have_content('space1')
    expect(page).to have_content('space2')
    expect(page).to have_content('space3')
  end

  xscenario 'enter dates and then clear to see all spaces' do
    add_test_spaces
    # add_test_requests
    visit('/makersbnb/space')
    fill_in("start_date", with: '2021-08-25')
    fill_in("end_date", with: '2021-09-01')
    click_button('Filter Spaces by Date')
    click_button('Clear filter')
    expect(page).to have_content('space1')
    expect(page).to have_content('space2')
    expect(page).to have_content('space3')
  end
end