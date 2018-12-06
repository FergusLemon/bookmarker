module CapybaraHelpers
  # thanks to Yanis Triandaphilov for the recommendation, sourced from his blog
  # https://blog.codeship.com/principles-of-effective-testing-with-capybara/
  def should_see(text)
    expect(page).to have_content(text)
  end

  def should_not_see(text)
    expect(page).not_to have_content(text)
  end

  def create_bookmark
    Bookmark.create('https://github.com', 'Github Homepage')
    visit '/bookmarks'
  end
end
