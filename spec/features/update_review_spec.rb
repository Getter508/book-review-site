require 'rails_helper'

# As the author of a review
# I want to update my review
# So that my review is accurate

# Acceptance Criteria:
  # I must be signed in and the author of the review to make edits
  # To make updates, I must provide a rating and will receive a notification
  # If I provide invalid information, the review is not updated and I receive
    # an error message

feature 'user tries to update a review' do
  scenario 'not signed in' do
    review = FactoryBot.create(:review)

    visit books_path
    click_on 'The Name of the Wind'

    expect(page).not_to have_content('Edit')
  end

  scenario 'not the author of the review' do
    user = FactoryBot.create(:user, admin: false)
    book = FactoryBot.create(:book)

    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    visit books_path
    click_on 'The Name of the Wind'

    expect(page).not_to have_content('Edit')
  end

  scenario 'author navigates to edit page' do
    review = FactoryBot.create(:review)

    visit new_user_session_path
    fill_in 'Email', with: review.user.email
    fill_in 'Password', with: review.user.password
    click_button 'Log in'

    visit books_path
    click_on 'The Name of the Wind'
    within(".reviews") do
      click_on('Edit')
    end

    expect(page).to have_content('Edit Review for: The Name of the Wind')
    expect(find_field('Rating').value).to eq('10')
    expect(find_field('Title').value).to eq('Best Book Ever!')
    expect(find_field('Body').value).to have_content('Patrick Rothfuss')
  end

  scenario 'author provides valid info' do
    review = FactoryBot.create(:review)

    visit new_user_session_path
    fill_in 'Email', with: review.user.email
    fill_in 'Password', with: review.user.password
    click_button 'Log in'

    visit books_path
    click_on 'The Name of the Wind'
    within(".reviews") do
      click_on('Edit')
    end
    select '9', from: 'Rating'
    click_on 'Submit'

    expect(page).to have_content('Your review was successfully updated')
    expect(page).to have_content('9 out of 10')
    expect(page).not_to have_content('Edit Review for')
  end

  scenario 'author provides invalid info' do
    review = FactoryBot.create(:review)

    visit new_user_session_path
    fill_in 'Email', with: review.user.email
    fill_in 'Password', with: review.user.password
    click_button 'Log in'

    visit books_path
    click_on 'The Name of the Wind'
    within(".reviews") do
      click_on('Edit')
    end

    select 'Select Rating', from: 'Rating'
    click_on 'Submit'

    expect(page).to have_content('is not a number')
    expect(page).to have_content("can't be blank")
    expect(page).to have_content('Edit Review for')
    expect(page).not_to have_content('out of 10')
  end
end
