feature 'Deleting a bookmark' do
  scenario 'A user deletes a bookmark from the list' do
    Bookmark.create('https://github.com', 'Github Homepage')
    visit '/bookmarks'
    click_button 'delete-bookmark'
    should_not_see 'Github Homepage'
    should_see 'No bookmarks have been added yet.'
  end
end
