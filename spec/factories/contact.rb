FactoryBot.define do
  factory :contact do
    name { Faker::Lorem.characters(number: 20) }
    email { Faker::Internet.email }
    subject { Faker::Lorem.characters(number: 50) }

    message { Faker::Lorem.characters(number: 500) }
  end
end
