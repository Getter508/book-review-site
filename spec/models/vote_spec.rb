require 'rails_helper'

RSpec.describe Vote, type: :model do
  scenario "vote has an upvote" do
    vote = FactoryBot.create(:vote)

    expect(vote.upvote.to_s).to eq('true')
  end
end
