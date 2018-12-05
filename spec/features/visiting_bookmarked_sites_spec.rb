feature 'Visiting Bookmarked Sites' do
  scenario 'User clicks on a bookmark and gets taken to the bookmarked site' do
    Bookmark.create('https://github.com', 'Github Homepage')
    visit '/bookmarks'
    click_link 'Github Homepage'
    expect(current_url).to have_content('github.com')
  end
end
