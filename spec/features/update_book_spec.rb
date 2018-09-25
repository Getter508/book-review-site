require 'rails_helper'

# As the creator of the book
# I want to update the book's information
# So that I can correct errors or provide new information

# Acceptance Criteria:
  # I must be signed in and the creator of the book to make changes
  # I must provide valid information to update a book
  # If I do provide invalid information, I receive an error message, the
    # changes are not saved, and the fields retain the last info filled

feature 'user tries to update a book' do
  scenario 'user is not signed in' do
    visit books_path

    expect(page).not_to have_content('Edit')
  end

  scenario 'user is not book creator' do
    user1 = FactoryBot.create(:user)
    user2 = FactoryBot.create(:user, last_name: 'Jones', email: 'you@you.com')
    book = FactoryBot.create(:book, user: user1)

    visit new_user_session_path

    fill_in 'Email', with: user2.email
    fill_in 'Password', with: user2.password
    click_button 'Log in'

    visit books_path

    expect(page).not_to have_content('Edit')
  end

  scenario 'creator navigates to edit page' do
    user = FactoryBot.create(:user)
    book = FactoryBot.create(:book, user: user)

    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    visit books_path
    click_on 'Edit'

    expect(page).to have_content('Use the form below to update this book')
    expect(find_field('Title').value).to eq('The Name of the Wind')
    expect(find_field('Author').value).to eq('Patrick Rothfuss')
    expect(find_field('Publication year').value).to eq('2007')
    expect(find_field('Genre').value).to eq('Fantasy')
    expect(find_field('Synopsis').value).to have_content('Kvothe')
  end

  scenario 'creator provides valid information' do
    user = FactoryBot.create(:user)
    book = FactoryBot.create(:book, user: user)

    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    visit books_path
    click_on 'Edit'

    select 'Drama', from: 'Genre'
    fill_in 'Synopsis', with: ''
    click_button 'Submit'

    expect(page).to have_content('This book was successfully updated')
    expect(page).to have_content('Drama')
    expect(page).not_to have_content('Kvothe')
    expect(page).not_to have_content('Use the form below to update this book')
  end

  scenario 'creator provides invalid information' do
    user = FactoryBot.create(:user)
    book = FactoryBot.create(:book, user: user)

    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    visit books_path
    click_on 'Edit'

    fill_in 'Title', with: ''
    click_button 'Submit'

    expect(page).to have_content('Use the form below to update this book')
    expect(page).to have_content("can't be blank")
    expect(find_field('Title').value).not_to eq('The Name of the Wind')
    expect(page).not_to have_content('This book was successfully updated')
  end
end
