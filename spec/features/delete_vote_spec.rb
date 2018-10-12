require 'rails_helper'

# As an authenticated user
# I want to delete my vote
# So that I can remove my opinion from a review

feature 'user tries to delete vote' do
  scenario 'user deletes upvote' do
    review = FactoryBot.create(:review)

    visit new_user_session_path
    fill_in 'Email', with: review.user.email
    fill_in 'Password', with: review.user.password
    click_button 'Log in'

    visit books_path
    click_on 'The Name of the Wind'
    click_on 'Upvote'
    click_on 'Upvote'

    expect(find('.net_votes')).to have_content(0)
  end

  scenario 'user deletes downvote' do
    review = FactoryBot.create(:review)

    visit new_user_session_path
    fill_in 'Email', with: review.user.email
    fill_in 'Password', with: review.user.password
    click_button 'Log in'

    visit books_path
    click_on 'The Name of the Wind'
    click_on 'Downvote'
    click_on 'Downvote'

    expect(find('.net_votes')).to have_content(0)
  end
end
