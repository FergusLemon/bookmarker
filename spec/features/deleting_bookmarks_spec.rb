feature 'Deleting a bookmark' do
  scenario 'A user deletes a bookmark from the list' do
    create_bookmark
    click_button 'delete-bookmark'
    should_not_see 'Github Homepage'
    should_see 'No bookmarks have been added yet.'
  end
end
