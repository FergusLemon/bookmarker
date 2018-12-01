feature 'Page headers are constant' do
  scenario 'Has branded header on the home page' do
    visit '/'
    expect(page).to have_css('#brand-header', :visible => false)
  end
end
