feature 'Viewing Bookmarks' do
  scenario 'Sees a message if no bookmarks have been added' do
    visit '/bookmarks'
    should_see 'No bookmarks have been added yet.'
  end
  scenario 'Sees bookmarks that have been added' do
    conn = PG.connect(dbname: 'bookmarker_test')
    conn.exec("INSERT INTO bookmarks(url) VALUES('https://github.com');")
    visit '/bookmarks'
    should_not_see 'No bookmarks have been added yet.'
    should_see 'https://github.com'
  end
end
