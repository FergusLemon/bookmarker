module CapybaraHelpers
  # thanks to Yanis Triandaphilov for the recommendation, sourced from his blog
  # https://blog.codeship.com/principles-of-effective-testing-with-capybara/
  def should_see(text)
    expect(page).to have_content(text)
  end
end
