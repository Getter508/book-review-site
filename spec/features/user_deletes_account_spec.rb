require 'rails_helper'

# As an authenticated user
# I want to delete my account
# So that my information is no longer retained by the app

# Acceptance Criteria:
  # If I am signed in, I have an option to delete my account

feature 'authenticated user tries to delete account' do
  scenario 'successfully deletes account' do
    user = FactoryBot.create(:user)

    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    visit edit_user_registration_path

    click_button 'Cancel my account'

    expect(page).to have_content('Your account has been successfully cancelled.')
    expect(page).to have_content('Sign Up')
    expect(page).not_to have_content('Edit User')
  end
end
