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

describe '#time_diff' do
  context 'calculates how long ago a review was created' do
    it 'calculates the time difference' do
      review = FactoryBot.create(:review, created_at: Time.zone.now - 30)

      expect(review.time_diff).to be_within(0.2).of(30)
    end
  end
end

describe '#display_time' do
  context 'displays how long ago a review was created' do
    it 'shows less than a minute' do
      review = FactoryBot.create(:review, created_at: Time.zone.now - 30)

      expect(review.display_time).to eq('less than 1m ago')
    end

    it 'shows how many minutes' do
      review = FactoryBot.create(:review, created_at: Time.zone.now - 600)

      expect(review.display_time).to eq('10m ago')
    end

    it 'shows how many hours' do
      review = FactoryBot.create(:review, created_at: Time.zone.now - 4000)

      expect(review.display_time).to eq('1h ago')
    end

    it 'shows how many days' do
      review = FactoryBot.create(:review, created_at: Time.zone.now - 87000)

      expect(review.display_time).to eq('1d ago')
    end
  end
end
