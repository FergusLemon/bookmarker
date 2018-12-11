module CapybaraHelpers
  # thanks to Yanis Triandaphilov for the recommendation, sourced from his blog
  # https://blog.codeship.com/principles-of-effective-testing-with-capybara/
  def should_see(text)
    expect(page).to have_content(text)
  end

  def should_not_see(text)
    expect(page).not_to have_content(text)
  end

  def create_bookmark(url, title)
    Bookmark.create(url, title)
    visit '/bookmarks'
  end

  def create_comment(comment)
    click_on 'add-comment'
    fill_in('comment', :with => comment)
    click_on 'submit-comment'
  end

  def create_tag(content, bookmark_id)
    Tag.create(content, bookmark_id)
    visit '/bookmarks'
  end
end
