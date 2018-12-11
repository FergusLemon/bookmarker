 feature 'Adding and viewing comments' do
   scenario 'A user can add a comment to a bookmark' do
    create_bookmark('https://github.com', 'Github Homepage')
    create_comment('This is a test comment')
    click_on 'comments'
    should_see 'This is a test comment'
   end

   scenario 'A user can view all comments on a bookmark' do
    create_bookmark('https://github.com', 'Github Homepage')
    create_comment('This is a test comment')
    create_comment('This is another test comment')
    click_on 'comments'
    should_see 'This is a test comment'
    should_see 'This is another test comment'
   end
 end
