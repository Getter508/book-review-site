require 'rails_helper'

# As an authenticated user
# I want to add a book
# So that others can review it

# Acceptance Criteria:
  # I must be signed in to add a book
  # To save a book, I must provide a title and author
  # If I am not signed in or do not provide the required information, I receive
    # an error message and the book is not saved

feature 'user tries to create a book' do
  scenario 'authenticated user provides valid information' do
    user = FactoryBot.create(:user)

    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    visit new_book_path
    fill_in 'Title', with: 'The Name of the Wind'
    fill_in 'First name', with: 'Patrick'
    fill_in 'Last name', with: 'Rothfuss'
    select 'Fantasy', from: 'Genre'
    attach_file('book[image]', Rails.root.join('spec', 'support', 'NameofWindCover.jpg'))
    click_button 'Submit'

    expect(page).to have_content('Book was submitted successfully')
    expect(page).not_to have_content('Use this form to submit a book')
    expect(page).not_to have_content('Add Book')
    expect(page).to have_xpath("//img[contains(@src,'NameofWindCover.jpg')]")
  end

  scenario 'authenticated user provides invalid information' do
    user = FactoryBot.create(:user)

    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    visit new_book_path
    fill_in 'Title', with: 'The Name of the Wind'
    select 'Fantasy', from: 'Genre'
    click_button 'Submit'

    expect(page).to have_content("can't be blank")
    expect(page).to have_content('Use this form to submit a book')
    expect(page).to have_content('Add Book')
  end

  scenario 'unauthenticated user cannot add a book' do
    visit books_path

    expect(page).not_to have_content('Submit a Book')
  end
end
