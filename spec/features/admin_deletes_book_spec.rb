require 'rails_helper'

# As an admin
# I want to delete a book
# If it does not belong on the site

# Acceptance Criteria:
  # I must be signed in and an admin
  # I must navigate to the book details page to delete a book and I will
    # receive a confirmation

feature 'admin tries to delete a book' do
  scenario 'not signed in' do
    book = FactoryBot.create(:book)

    visit books_path
    click_on 'The Name of the Wind'

    expect(page).not_to have_content('Delete')
  end

  scenario 'not admin (or author)' do
    user1 = FactoryBot.create(:user, first_name: 'Jane', last_name: 'Doe', admin: false)
    book = FactoryBot.create(:book)

    visit new_user_session_path
    fill_in 'Email', with: user1.email
    fill_in 'Password', with: user1.password
    click_button 'Log in'

    visit books_path
    click_on 'The Name of the Wind'

    expect(page).not_to have_content('Delete')
  end

  scenario 'successfully deletes book' do
    user1 = FactoryBot.create(:user, first_name: 'Jane', last_name: 'Doe')
    book = FactoryBot.create(:book)

    visit new_user_session_path
    fill_in 'Email', with: user1.email
    fill_in 'Password', with: user1.password
    click_button 'Log in'

    visit books_path
    click_on 'The Name of the Wind'

    within(".book_details") do
      click_on 'Delete'
    end

    expect(page).to have_content('This book was successfully deleted')
    expect(page).to have_content('Submit a Book')
    expect(page).not_to have_content('The Name of the Wind')
  end
end
