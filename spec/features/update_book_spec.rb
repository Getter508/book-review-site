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
    book = FactoryBot.create(:book)

    visit books_path
    click_on 'The Name of the Wind'

    within(".book_details") do
      expect(page).not_to have_content('Edit')
    end
  end

  scenario 'user is not book creator' do
    user = FactoryBot.create(:user, admin: false)
    book = FactoryBot.create(:book)

    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    visit books_path
    click_on 'The Name of the Wind'

    within(".book_details") do
      expect(page).not_to have_content('Edit')
    end
  end

  scenario 'creator navigates to edit page' do
    book = FactoryBot.create(:book)

    visit new_user_session_path
    fill_in 'Email', with: book.user.email
    fill_in 'Password', with: book.user.password
    click_button 'Log in'

    visit books_path
    click_on 'The Name of the Wind'
    click_on 'Edit'

    expect(page).to have_content('Use the form below to update this book')
    expect(find_field('Title').value).to eq('The Name of the Wind')
    expect(find_field('First name').value).to eq('Patrick')
    expect(find_field('Last name').value).to eq('Rothfuss')
    expect(find_field('Publication year').value).to eq('2007')
    expect(find_field('Genre').value).to eq('Fantasy')
    expect(find_field('Synopsis').value).to have_content('Kvothe')
  end

  scenario 'creator provides valid information' do
    book = FactoryBot.create(:book)

    visit new_user_session_path
    fill_in 'Email', with: book.user.email
    fill_in 'Password', with: book.user.password
    click_button 'Log in'

    visit books_path
    click_on 'The Name of the Wind'
    click_on 'Edit'

    select 'Drama', from: 'Genre'
    fill_in 'Synopsis', with: ''
    attach_file('book[image]', Rails.root.join('spec', 'support', 'NameofWindCover.jpg'))
    click_button 'Submit'

    expect(page).to have_content('This book was successfully updated')
    expect(page).to have_content('Drama')
    expect(page).to have_xpath("//img[contains(@src,'NameofWindCover.jpg')]")
    expect(page).not_to have_content('Kvothe')
    expect(page).not_to have_content('Use the form below to update this book')
  end

  scenario 'creator provides invalid information' do
    book = FactoryBot.create(:book)

    visit new_user_session_path
    fill_in 'Email', with: book.user.email
    fill_in 'Password', with: book.user.password
    click_button 'Log in'

    visit books_path
    click_on 'The Name of the Wind'
    click_on 'Edit'

    fill_in 'Title', with: ''
    click_button 'Submit'

    expect(page).to have_content('Use the form below to update this book')
    expect(page).to have_content("can't be blank")
    expect(find_field('Title').value).not_to eq('The Name of the Wind')
    expect(page).not_to have_content('This book was successfully updated')
  end
end
