feature 'Adding Bookmarks' do
  scenario 'Sees an option to add a bookmark' do
    visit '/bookmarks'
    expect(page).to have_css('#enter-url')
    expect(page).to have_css('#add-bookmark')
  end
  scenario 'Sees the new bookmark in the list after adding a new bookmark' do
    visit '/bookmarks'
    fill_in('url', :with => 'https://github.com')
    click_on 'add-bookmark'
    expect(page).to have_content('https://github.com')
  end
end
