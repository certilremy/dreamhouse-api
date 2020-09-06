FactoryBot.define do
  factory :user do
    username { Faker::Lorem.words(number: 8) }
  end
end
