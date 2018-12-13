feature 'User registration' do
  scenario 'A new user can sign up to the Bookmarker app' do
    visit '/'
    click_on 'Sign Up'
    fill_in 'username',  with: 'test@gmail.com'
    fill_in 'password', with: 'myPa$$word'
    click_on 'Submit'
    should_see 'No bookmarks have been added yet'
  end
end
