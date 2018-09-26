require 'rails_helper'

# As a user
# I want to view a list of reviews for a book
# So that I can see what people think

# Acceptance Criteria:
  # A list of reviews is accessable on a book's show page
  # Only the reviews specific to that book are listed

feature 'user tries to view a list of reviews' do
  scenario 'user views reviews of a book' do
    book1 = FactoryBot.create(:book, title: "The Wise Man's Fear")
    review = FactoryBot.create(:review)
    review1 = FactoryBot.create(:review, book: book1)

    visit books_path
    click_on 'The Name of the Wind'

    expect(page).to have_content('Patrick Rothfuss', count: 2)
    expect(page).not_to have_content("The Wise Man's Fear")
  end
end
