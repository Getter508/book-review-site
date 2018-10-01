FactoryBot.define do
  factory :user do
    first_name {"Sarah"}
    last_name {"Getter"}
    admin {true}
    sequence(:username) { |n| "getters#{n}" }
    sequence(:email) { |n| "me#{n}@me.com" }
    password {"password"}
  end
end
