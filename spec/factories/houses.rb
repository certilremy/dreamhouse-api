FactoryBot.define do
  factory :house do
    name { Faker::Lorem.words(number: 8) }
    description { Faker::Lorem.sentence(word_count: 8) }
    user_id { nil }
    price { Faker::Number.number(10) }
  end
end
