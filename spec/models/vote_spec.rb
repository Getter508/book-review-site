require 'rails_helper'

RSpec.describe Vote, type: :model do
  scenario "has an upvote" do
    vote = FactoryBot.create(:vote)

    expect(vote.upvote).to be true
  end
end

describe '.update_or_destroy' do
  context 'controls voting on reviews' do
    it 'creates a vote' do
      review = FactoryBot.create(:review)
      upvote = true
      Vote.update_or_destroy(review.user, review, upvote)

      expect(review.net_upvotes).to eq(1)
    end

    it 'deletes a vote' do
      review = FactoryBot.create(:review)
      vote = FactoryBot.create(:vote, review: review)
      Vote.update_or_destroy(vote.user, review, 'true')

      expect(review.net_upvotes).to eq(0)
    end

    it 'updates a vote' do
      review = FactoryBot.create(:review)
      vote = FactoryBot.create(:vote, review: review)
      Vote.update_or_destroy(vote.user, review, 'false')

      expect(review.net_upvotes).to eq(-1)
    end
  end
end

describe '#set_div_class' do
  context 'adds to the div' do
    it 'up with warning' do
      vote = FactoryBot.create(:vote)

      expect(vote.set_div_class(vote.user, true)).to eq("up callout small warning")
    end

    it 'up without warning' do
      vote = FactoryBot.create(:vote, upvote: false)

      expect(vote.set_div_class(vote.user, true)).to eq("up callout small")
    end

    it 'down with warning' do
      vote = FactoryBot.create(:vote, upvote: false)

      expect(vote.set_div_class(vote.user, false)).to eq("down callout small warning")
    end

    it 'down without warning' do
      vote = FactoryBot.create(:vote)

      expect(vote.set_div_class(vote.user, false)).to eq("down callout small")
    end
  end
end
