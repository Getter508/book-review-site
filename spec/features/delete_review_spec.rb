require 'rails_helper'

# As the author of a review
# I want to delete my review
# So that others cannot see or rate it

# Acceptance Criteria:
  # I must be signed in and the author to delete a review
  # The review and any ratings are removed from the book details page and I
    # receive a notification that the review was removed

feature 'user tries to delete a review' do
  scenario 'not signed in' do
    review = FactoryBot.create(:review)

    visit books_path
    click_on 'The Name of the Wind'

    expect(page).not_to have_content('Delete')
  end

  scenario 'not the author of the review' do
    user = FactoryBot.create(:user, admin: false)
    review = FactoryBot.create(:review)

    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    visit books_path
    click_on 'The Name of the Wind'

    expect(page).to have_content('Kvothe')
    expect(page).to have_content('Best Book Ever!')
    expect(page).not_to have_content('Delete')
  end

  scenario 'author successfully deletes review' do
    review = FactoryBot.create(:review)

    visit new_user_session_path
    fill_in 'Email', with: review.user.email
    fill_in 'Password', with: review.user.password
    click_button 'Log in'

    visit books_path
    click_on 'The Name of the Wind'

    within(".view_reviews") do
      click_on 'Delete'
    end

    expect(page).to have_content('Your review was successfully deleted')
    expect(page).to have_content('Kvothe')
    expect(page).not_to have_content('10 out of 10')
    expect(page).not_to have_content('Best Book Ever!')
  end
end
