feature 'Adding and viewing tags' do
  scenario 'A user can add a tag to a bookmark' do
    create_bookmark('https://github.com', 'Github Homepage')
    create_tag('Test', '1')
    click_on 'tags'
    should_see 'Test'
  end
end
