feature 'Visiting Bookmarked Sites' do
  scenario 'User clicks on a bookmark and gets taken to the bookmarked site' do
    create_bookmark('https://github.com', 'Github Homepage')
    click_link 'Github Homepage'
    expect(current_url).to have_content('github.com')
  end
end
