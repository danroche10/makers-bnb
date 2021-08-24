
feature ' users can view the home page' do
  scenario 'expects user to see welcome to makersbnb' do
    visit '/makersbnb'
    expect(page).to have_content 'Welcome to Makersbnb!' 
  end


end