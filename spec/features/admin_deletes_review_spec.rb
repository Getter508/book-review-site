require 'rails_helper'

# As an admin
# I want to delete a review
# If it is inappropriate

# Acceptance Criteria:
  # I must be signed in and an admin
  # I must be on the book details page to delete a review
  # I will receive a notification when the review is deleted successfully

feature 'admin tries to delete a review' do
  scenario 'not signed in' do
    review = FactoryBot.create(:review)

    visit books_path
    click_on 'The Name of the Wind'

    expect(page).not_to have_content('Delete')
  end

  scenario 'not an admin (or author)' do
    user1 = FactoryBot.create(:user, first_name: 'Jane', last_name: 'Doe', admin: false)
    review = FactoryBot.create(:review)

    visit new_user_session_path
    fill_in 'Email', with: user1.email
    fill_in 'Password', with: user1.password
    click_button 'Log in'

    visit books_path
    click_on 'The Name of the Wind'

    expect(page).not_to have_content('Delete')
  end

  scenario 'successfully deletes the review' do
    user1 = FactoryBot.create(:user, first_name: 'Jane', last_name: 'Doe')
    review = FactoryBot.create(:review)

    visit new_user_session_path
    fill_in 'Email', with: user1.email
    fill_in 'Password', with: user1.password
    click_button 'Log in'

    visit books_path
    click_on 'The Name of the Wind'

    within(".view_reviews") do
      click_on 'Delete'
    end

    expect(page).to have_content('Your review was successfully deleted')
    expect(page).to have_content('Post a Review')
    expect(page).to have_content('The Name of the Wind')
  end
end
