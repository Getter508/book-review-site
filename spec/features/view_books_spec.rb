require 'rails_helper'

# As a user
# I want to view a list of books
# So that I can pick items to review

# As a user
# I want to view the details about a book
# So that I can get more information about it

# Acceptance Criteria:
  # I can view the list of submitted book titles
  # If I click on a title, I want to view that book's details

feature 'user views the books' do
  scenario 'list of book titles are displayed' do
    book = FactoryBot.create(:book)

    visit books_path

    expect(page).to have_content('The Name of the Wind')
  end

  scenario 'details of a book are displayed' do
    book = FactoryBot.create(:book)

    visit books_path
    click_on 'The Name of the Wind'

    expect(page).to have_content('Patrick Rothfuss')
    expect(page).to have_content('2007')
    expect(page).to have_content('Fantasy')
    expect(page).to have_content('Kvothe')
  end
end
