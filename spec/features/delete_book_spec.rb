require 'rails_helper'

# As the creator of the book
# I want to delete the book
# So that no one can review it

# Acceptance Criteria:
  # I must be signed in and the creator of the book to delete it
  # Associated reviews and ratings should be deleted when the book is deleted

feature 'user tries to delete a book' do
  scenario 'user is not signed in' do
    book = FactoryBot.create(:book)

    visit books_path
    click_on 'The Name of the Wind'

    expect(page).to have_content('Kvothe')
    expect(page).not_to have_content('Delete')
  end

  scenario 'user did not create the book' do
    user1 = FactoryBot.create(:user)
    user2 = FactoryBot.create(:user, last_name: 'Jones', email: 'you@you.com')
    book = FactoryBot.create(:book, user: user1)

    visit new_user_session_path

    fill_in 'Email', with: user2.email
    fill_in 'Password', with: user2.password
    click_button 'Log in'

    visit books_path
    click_on 'The Name of the Wind'

    expect(page).to have_content('Kvothe')
    expect(page).not_to have_content('Delete')
  end

  scenario 'creator can access delete button' do
    user = FactoryBot.create(:user)
    book = FactoryBot.create(:book, user: user)

    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    visit books_path
    click_on 'The Name of the Wind'

    expect(page).to have_content('Kvothe')
    expect(page).to have_content('Delete')
  end

  scenario 'creator deletes the book' do
    user = FactoryBot.create(:user)
    book = FactoryBot.create(:book, user: user)

    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    visit books_path
    click_on 'The Name of the Wind'
    click_on 'Delete'

    expect(page).not_to have_content('Kvothe')
    expect(page).not_to have_content('Delete')
    expect(page).not_to have_content('The Name of the Wind')
    expect(page).to have_content('Submit a Book')
  end
end
