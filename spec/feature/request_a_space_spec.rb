feature 'request a space' do
  scenario 'as a logged in guest I want to request a space to rent' do
    add_test_data
    login
    visit('/makersbnb/spaces')
    click_link('space1')
    fill_in('start_date', with: "2021-12-01")
    fill_in('end_date', with: "2021-12-26")
    click_button('Check availability')
    click_button('Request the Space')
    expect(page).to have_current_path('/makersbnb/requests')
    expect(page).to have_content('space1')
    expect(page).to have_content('Pending')
  end

  scenario 'as a logged in space owner I want to see space requests and approve a request' do
    add_test_data
    login_space_owner
    visit('/makersbnb')
    click_link('Requests')
    expect(page).to have_current_path('/makersbnb/requests')
    expect(page).to have_content('2021-08-25')
    expect(page).to have_content('Pending')
    click_button('Approve')
    # expect(page).to have_content('xxxx')
  end

  scenario 'as a logged in space owner I want to see space requests and deny a request' do
    add_test_data
    login_space_owner
    visit('/makersbnb')
    click_link('Requests')
    expect(page).to have_current_path('/makersbnb/requests')
    expect(page).to have_content('2021-08-25')
    expect(page).to have_content('Pending')
    click_button('Deny')
    # expect(page).to have_content('xxxx')
  end
end