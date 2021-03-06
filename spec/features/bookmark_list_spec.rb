feature 'Viewing Bookmarks' do
  scenario 'Sees a message if no bookmarks have been added' do
    visit '/bookmarks'
    should_see 'No bookmarks have been added yet.'
  end
  scenario 'Sees bookmarks that have been added' do
    create_bookmark('https://github.com', 'Github Homepage')
    should_not_see 'No bookmarks have been added yet.'
    should_see 'Github Homepage'
  end
end
