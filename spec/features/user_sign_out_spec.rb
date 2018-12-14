feature 'User sign out' do
  scenario 'A signed in user can sign out' do
    User.create(username: 'test@gmail.com', password: 'myPa$$word')
    visit '/'
    click_on 'Sign In'
    fill_in 'username', with: 'test@gmail.com'
    fill_in 'password', with: 'myPa$$word'
    click_on 'Submit'
    click_on 'Sign out'
    should_see 'You have successfully logged out'
  end
end
