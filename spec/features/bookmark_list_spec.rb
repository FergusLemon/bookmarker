feature 'Getting a List of All Bookmarks' do
  scenario 'When no bookmarks have been added' do
    allow(Bookmark.all).to receive(:empty?).and_return(true)
    visit '/'
    should_see 'No bookmarks have been added yet.'
  end
  scenario 'When bookmarks have been added' do
    allow(Bookmark.all).to receive(:empty?).and_return(false)
    visit '/'
    should_not_see 'No bookmarks have been added yet.'
  end
  scenario 'Viewing the list of bookmarks' do
    allow(Bookmark).to receive(:all).and_return('https://github.com')
    visit '/bookmarks'
    should_see 'https://github.com'
  end
end
