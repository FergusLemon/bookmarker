feature 'Editing bookmarks' do
  scenario 'User can edit an existing bookmark' do
    create_bookmark
    click_button 'edit-bookmark'
    fill_in('url', :with => 'https://reddit.com')
    fill_in('title', :with => 'Reddit Homepage')
    click_button 'update-bookmark'
    should_see 'Reddit Homepage'
    should_not_see 'Github Homepage'
    click_link 'Reddit Homepage'
    expect(current_url).to have_content('https://reddit.com')
  end
end
