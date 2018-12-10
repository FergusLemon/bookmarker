feature 'Adding and viewing tags' do
  scenario 'A user can add a tag to a bookmark' do
    create_bookmark
    click_on 'add-tag'
    fill_in('tag', :with => 'This is a test tag')
    click_on 'create-tag'
    click_on 'tags'
    should_see 'This is a test tag'
  end
end
