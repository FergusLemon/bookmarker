feature 'Viewing all bookmarks that have the same tag' do
  scenario 'A user can see all bookmarks that have a specific tag' do
    create_bookmark('https://github.com', 'Github Homepage')
    create_bookmark('https://reddit.com', 'Reddit Homepage')
    create_tag('Funny', '1')
    create_tag('Funny', '2')
    first('.tags').click_on 'tags'
    click_on 'bookmarks'
    should_see 'Github Homepage'
    should_see 'Reddit Homepage'
  end
end
