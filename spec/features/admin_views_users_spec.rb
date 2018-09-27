require 'rails_helper'

# As an admin
# I want to view a list of users
# So that I know who has an account

# Acceptance Criteria:
  # I must be signed in and an admin to view a list of users

feature 'admin tries to view a list of users' do
  scenario 'not signed in' do
    visit '/'

    expect(page).not_to have_content('Users')
  end

  scenario 'user not an admin' do
    user = FactoryBot.create(:user, admin: false)

    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    expect(page).not_to have_content('Users')
  end

  scenario 'admin can access user list' do
    user = FactoryBot.create(:user)

    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    expect(page).to have_content('Users')
  end

  scenario 'admin views user list' do
    user = FactoryBot.create(:user)

    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    click_on 'Users'

    expect(page).to have_content('Getter, Sarah')
    expect(page).to have_content(user.email)
  end
end
