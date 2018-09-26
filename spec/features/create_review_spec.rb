require 'rails_helper'

# As an authenticated user
# I want to create a review for a book
# So that others know my opinion

# Acceptance Criteria:
  # I must be signed in to add a review
  # I access the review form on the book details page
  # I must provide a title and body to save a review and will receive a notice
    # when the review is successfully saved
  # If I do not provide valid information, I receive an error message and the
    # review does not save

feature 'user tries to add a review' do
  scenario 'not signed in' do
    book = FactoryBot.create(:book)

    visit books_path
    click_on 'The Name of the Wind'

    expect(page).not_to have_content('Post a Review')
  end

  scenario 'authenticated user navigates to review form' do
    book = FactoryBot.create(:book)

    visit new_user_session_path
    fill_in 'Email', with: book.user.email
    fill_in 'Password', with: book.user.password
    click_button 'Log in'

    visit books_path
    click_on 'The Name of the Wind'

    expect(page).to have_content('Post a Review')
  end

  scenario 'provides valid information' do
    book = FactoryBot.create(:book)

    visit new_user_session_path
    fill_in 'Email', with: book.user.email
    fill_in 'Password', with: book.user.password
    click_button 'Log in'

    visit books_path
    click_on 'The Name of the Wind'

    fill_in 'Title', with: 'Best Book Ever!'
    fill_in 'Body', with: "I could not put it down! Already halfway through \
      the second book in the series and cannot wait for the third! Patrick \
      Rothfuss is a literary genius."
    click_on 'Submit'

    expect(find_field('Title').value).to eq(nil)
    expect(find_field('Body').value).to eq('')
    expect(page).to have_content('Patrick Rothfuss', count: 2)
    expect(page).to have_content('Your review was posted successfully')
  end

  scenario 'provides invalid information' do
    book = FactoryBot.create(:book)

    visit new_user_session_path
    fill_in 'Email', with: book.user.email
    fill_in 'Password', with: book.user.password
    click_button 'Log in'

    visit books_path
    click_on 'The Name of the Wind'
    fill_in 'Title', with: 'Best Book Ever!'
    click_on 'Submit'

    expect(find_field('Title').value).to eq('Best Book Ever!')
    expect(find_field('Body').value).to eq('')
    expect(page).to have_content("can't be blank")
  end
end
