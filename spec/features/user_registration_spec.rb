feature 'User registration' do
  scenario 'A new user can sign up to the Bookmarker app' do
    visit '/'
    fill_in 'username',  with: 'New User 1'
    fill_in 'password', with: 'myPa$$word'
    click_on 'Sign Up'
    should_see 'No bookmarks have been added yet'
  end
end
