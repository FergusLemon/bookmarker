feature 'User sign in' do
  scenario 'An existing user can sign in' do
    User.create(username: 'test@gmail.com', password: 'myPa$$word')
    visit '/'
    click_on 'Sign In'
    fill_in 'username', with: 'test@gmail.com'
    fill_in 'password', with: 'myPa$$word'
    click_on 'Submit'
    should_see 'Logged in as test@gmail.com'
  end
  scenario 'If the wrong username or password is provided an error message is shown' do
    User.create(username: 'test@gmail.com', password: 'myPa$$word')
    visit '/'
    click_on 'Sign In'
    fill_in 'username', with: 'test11@gmail.com'
    fill_in 'password', with: 'myPa$$word'
    click_on 'Submit'
    should_see 'The username or password entered were incorrect, please try again.'
    fill_in 'username', with: 'test11@gmail.com'
    fill_in 'password', with: 'myPa$$word'
    click_on 'Submit'
    should_see 'The username or password entered were incorrect, please try again.'
  end
end
