require 'rails_helper'

# As an unauthenticated user
# I want to sign in
# So that I can post books and review them

# Acceptance Criteria:
  # If I'm signed out, I have an option to sign in
  # When I sign in, I receive a confirmation message and am directed to the
    # home page

feature 'user tries to sign in' do
  scenario 'specify valid credentials' do
    user = FactoryBot.create(:user)

    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    expect(page).to have_content('Signed in successfully')
    expect(page).to have_content('Sign Out')
  end

  scenario 'specify invalid credentials' do
    visit new_user_session_path
    click_button 'Log in'
    
    expect(page).to have_content('Invalid Email or password')
    expect(page).to_not have_content('Sign Out')
  end
end
