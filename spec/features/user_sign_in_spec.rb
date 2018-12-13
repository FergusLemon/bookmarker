feature 'User sign in' do
  scenario 'An existing user can sign in' do
    User.create(username: 'test@gmail.com', password: 'myPa$$word')
    visit '/'
    click_on 'Sign in'
    fill_in 'username', with: 'test@gmail.com'
    fill_in 'password', with: 'myPa$$word'
    click_on 'Submit'
    should_see 'Logged in as test@gmail.com'
  end
end
