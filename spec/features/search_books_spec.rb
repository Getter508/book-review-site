require 'rails_helper'

# As a user
# I want to search the books
# So that I can more easily find what I am looking for

# Acceptance Criteria:
  # I can access the search bar on any page
  # My search is matched against title, author, and synopsis
  # If there are results, they are presented as a list of books
  # If there are no results, I receive an error message

feature 'user tries to search' do
  scenario 'user successfully searches for a book' do
    book = FactoryBot.create(:book)

    visit books_path
    fill_in 'search', with: 'kvothe'
    click_on 'Search'

    expect(page).to have_content('The Name of the Wind')
  end

  scenario 'user successfully searches for books by an author' do
    book1 = FactoryBot.create(:book, title: "The Wise Man's Fear")
    book2 = FactoryBot.create(:book)

    visit books_path
    fill_in 'search', with: 'Patrick Rothfuss'
    click_on 'Search'

    expect(page).to have_content('The Name of the Wind', count: 1)
    expect(page).to have_content("The Wise Man's Fear", count: 1)
  end

  scenario 'user cannot find a book' do
    book = FactoryBot.create(:book)

    visit books_path
    fill_in 'search', with: 'Martin'
    click_on 'Search'

    expect(page).to have_content('There are no books containing "Martin"')
  end
end
