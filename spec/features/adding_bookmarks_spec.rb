feature 'Adding Bookmarks' do
  scenario 'Sees an option to add a bookmark' do
    visit '/bookmarks'
    should_see 'If you would like to add a new bookmark, enter the URL below:'
    expect(page).to have_css('#enter-url')
    expect(page).to have_css('#add-bookmark')
  end
end
