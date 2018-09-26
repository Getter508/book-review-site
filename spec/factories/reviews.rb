FactoryBot.define do
  factory :review do
    title {"Best Book Ever!"}
    body {"I could not put it down! Already halfway through the second book in \
      the series and cannot wait for the third! Patrick Rothfuss is a literary \
      genius."}

    user
    book
  end
end
