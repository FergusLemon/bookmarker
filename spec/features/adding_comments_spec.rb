 feature 'Adding comments' do
   scenario 'User adds a comment to a bookmark' do
    create_bookmark
    click_on 'add-comment'
    fill_in('comment', :with => 'This is a test comment')
    click_on 'submit-comment'
    click_on 'comments'
    should_see 'This is a test comment'
   end
 end
