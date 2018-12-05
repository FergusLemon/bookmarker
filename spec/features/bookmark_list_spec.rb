feature 'Viewing Bookmarks' do
  scenario 'Sees a message if no bookmarks have been added' do
    visit '/bookmarks'
    should_see 'No bookmarks have been added yet.'
  end
  scenario 'Sees bookmarks that have been added' do
    Bookmark.create('https://github.com', 'Github Homepage')
    visit '/bookmarks'
    should_not_see 'No bookmarks have been added yet.'
    should_see 'https://github.com'
  end
end
