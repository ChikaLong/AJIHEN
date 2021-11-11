FactoryBot.define do
  factory :comment do
    user
    post
    comment { Faker::Lorem.characters(number: 500) }
  end
end