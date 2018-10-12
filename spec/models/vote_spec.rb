require 'rails_helper'

RSpec.describe Vote, type: :model do
  scenario "has an upvote" do
    vote = FactoryBot.create(:vote)

    expect(vote.upvote).to be true
  end
end
