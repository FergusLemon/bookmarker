feature 'Getting a List of All Bookmarks' do
  scenario 'When no bookmarks have been added' do
    visit '/'
    should_see 'No bookmarks have been added yet.'
  end
end
