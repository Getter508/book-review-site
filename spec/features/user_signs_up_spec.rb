require 'rails_helper'

# As a prospective user
# I want to create an account
# So that I can post books and review them

# Acceptance Criteria:
  # I must specify a first and last name, a valid email address, password, and
    # password confirmation; optionally, a profile image
  # If I don't specify the required information, I am presented with an error
    # message

feature 'new user tries to sign up' do
  scenario 'provide valid registration information' do
    visit new_user_registration_path

    fill_in 'First name', with: 'Sarah'
    fill_in 'Last name', with: 'Getter'
    fill_in 'Email', with: 'me@me.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'

    click_button 'Sign up'

    expect(page).to have_content('Welcome! You have signed up successfully.')
    expect(page).to have_content('Sign Out')
  end

  scenario 'provide invalid registration information' do
    visit new_user_registration_path

    click_button 'Sign up'
    expect(page).to have_content("can't be blank")
    expect(page).to_not have_content('Sign Out')
  end
end
