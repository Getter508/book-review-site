require 'rails_helper'

# As an authenticated user
# I want to update my vote
# So that my opinion is current

feature 'user tries to update vote' do
  scenario 'user updates upvote to downvote' do
    review = FactoryBot.create(:review)

    visit new_user_session_path
    fill_in 'Email', with: review.user.email
    fill_in 'Password', with: review.user.password
    click_button 'Log in'

    visit books_path
    click_on 'The Name of the Wind'
    click_on 'Upvote'
    click_on 'Downvote'

    expect(find(".net_votes_#{review.id}")).to have_content(-1)
  end

  scenario 'user updates downvote to upvote' do
    review = FactoryBot.create(:review)

    visit new_user_session_path
    fill_in 'Email', with: review.user.email
    fill_in 'Password', with: review.user.password
    click_button 'Log in'

    visit books_path
    click_on 'The Name of the Wind'
    click_on 'Downvote'
    click_on 'Upvote'

    expect(find(".net_votes_#{review.id}")).to have_content(1)
  end
end
