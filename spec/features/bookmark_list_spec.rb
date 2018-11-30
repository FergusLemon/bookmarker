feature 'Getting a List of All Bookmarks' do
  scenario 'When no bookmarks have been added' do
    visit '/'
    expect(page).to have_content('No bookmarks have been added yet.')
  end
end
