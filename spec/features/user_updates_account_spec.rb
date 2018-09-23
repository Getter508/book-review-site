require 'rails_helper'

# As an authenticated user
# I want to update my information
# So that I can keep my profile up to date

# Acceptance Criteria:
  # If I'm signed in, I have an option to edit my profile information
  # To save updates to my profile, I must provide valid information
  # If the information is invalid, I receive an error message and changes are
    # not saved

feature 'authenticated user tries to update account' do
  scenario 'provide valid information' do
    user = FactoryBot.create(:user)

    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    visit edit_user_registration_path

    fill_in 'First name', with: 'Person'
    fill_in 'Current password', with: user.password

    click_button 'Update'

    expect(page).to have_content('Your account has been updated successfully.')
    expect(page).not_to have_content('Edit User')
  end

  scenario 'provide invalid information' do
    user = FactoryBot.create(:user)

    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    visit edit_user_registration_path

    fill_in 'First name', with: ''
    fill_in 'Current password', with: user.password

    click_button 'Update'

    expect(page).to have_content("can't be blank")
    expect(page).to have_content('Edit User')
  end
end
