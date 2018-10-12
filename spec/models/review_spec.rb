require 'rails_helper'

RSpec.describe Review, type: :model do
  scenario "has a rating, optionally a review title and body" do
    review = FactoryBot.create(:review)

    expect(review.rating).to eq(10)
    expect(review.title).to eq('Best Book Ever!')
    expect(review.body).to eq("I could not put it down! Already halfway through the second book in \
      the series and cannot wait for the third! Patrick Rothfuss is a literary \
      genius.")
  end
end

describe '#net_upvotes' do
  context 'displays the net upvotes' do
    it 'has one upvote' do
      review = FactoryBot.create(:review)
      vote = FactoryBot.create(:vote, review: review)

      expect(review.net_upvotes).to eq(1)
    end

    it 'has one downvote' do
      review = FactoryBot.create(:review)
      vote = FactoryBot.create(:vote, upvote: false, review: review)

      expect(review.net_upvotes).to eq(-1)
    end
  end
end
