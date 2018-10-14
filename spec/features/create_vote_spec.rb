require 'rails_helper'

# As an authenticated user
# I want to vote on others' ratings/reviews
# So that they know what I think of their opinions

feature 'user tries to vote' do
  scenario 'not signed in' do
    review = FactoryBot.create(:review)

    visit books_path
    click_on 'The Name of the Wind'
    click_on 'Upvote'

    expect(page).not_to have_content('Reviews')
    expect(page).to have_content('You need to sign in')
  end

  scenario 'user upvotes' do
    review = FactoryBot.create(:review)

    visit new_user_session_path
    fill_in 'Email', with: review.user.email
    fill_in 'Password', with: review.user.password
    click_button 'Log in'

    visit books_path
    click_on 'The Name of the Wind'
    click_on 'Upvote'

    expect(find(".net_votes_#{review.id}")).to have_content(1)
  end

  scenario 'user downvotes' do
    review = FactoryBot.create(:review)

    visit new_user_session_path
    fill_in 'Email', with: review.user.email
    fill_in 'Password', with: review.user.password
    click_button 'Log in'

    visit books_path
    click_on 'The Name of the Wind'
    click_on 'Downvote'

    expect(find(".net_votes_#{review.id}")).to have_content(-1)
  end
end
