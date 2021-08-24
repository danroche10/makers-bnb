feature 'view a space' do
  scenario 'click on individual space' do
    add_test_spaces
    visit ('/makersbnb/spaces')
    click_link('space1')
    expect(page).to have_current_path('/makersbnb/spaces/1')
    expect(page).to have_content('space1')
    expect(page).to have_content('semi comfortable')
    expect(page).to have_content('10000')
  end
end