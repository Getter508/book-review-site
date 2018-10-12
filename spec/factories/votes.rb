FactoryBot.define do
  factory :vote do
    upvote {true}

    user
    review
  end
end
