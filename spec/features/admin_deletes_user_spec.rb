require 'rails_helper'

# As an admin
# I want to delete a user
# So that the user no longer has an account

# Acceptance Criteria:
  # I must be signed in and an admin
  # I can delete users from the user index page and I receive a confirmation

feature 'admin tries to delete a user' do
  scenario 'successfully deletes user' do
    user = FactoryBot.create(:user, first_name: 'Jane', last_name: 'Doe')
    admin = FactoryBot.create(:user)

    visit new_user_session_path
    fill_in 'Email', with: admin.email
    fill_in 'Password', with: admin.password
    click_button 'Log in'
    click_on 'Users'

    within first(".user") do
      click_on 'Delete'
    end

    expect(page).to have_content('User was deleted successfully')
    expect(page).not_to have_content('Doe, Jane')
    expect(page).to have_content('Getter, Sarah')
  end
end
