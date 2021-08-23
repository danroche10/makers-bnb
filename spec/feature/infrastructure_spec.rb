feature 'hello' do
  it 'should say hello' do
    visit ('/makersbnb')
    expect(page).to have_content('Hello!')
  end
end