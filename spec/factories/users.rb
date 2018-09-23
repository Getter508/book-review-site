FactoryBot.define do
  factory :user do
    first_name {"Sarah"}
    last_name {"Getter"}
    admin {true}
    email {"me@me.com"}
    password {"password"}
  end
end
