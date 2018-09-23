require 'rails_helper'

# As an authenticated user
# I want to sign out
# So that no one else can post books or reviews on my behalf

# Acceptance Criteria:
  # If I'm signed in, I have an option to sign out
  # When I sign out, I receive a confirmation and can no longer access member
    # information

feature 'user signs out' do
  scenario 'authenticated user signs out' do
    user = FactoryBot.create(:user)

    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_button 'Log in'

    expect(page).to have_content('Signed in successfully')

    click_link 'Sign Out'
    expect(page).to have_content('Signed out successfully')
  end

  scenario 'unauthenticated user attempts to sign out' do
    visit '/'
    
    expect(page).to_not have_content('Sign Out')
  end
end
