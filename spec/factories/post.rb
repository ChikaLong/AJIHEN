FactoryBot.define do
  factory :post do
    user
    image_id { Faker::Lorem.characters(number: 10) }
    item_name { Faker::Lorem.characters(number: 50) }
    review { Faker::Lorem.characters(number: 1000) }
    country { '日本' }
    place { 'スーパー' }
    price { '300円' }
    rate { '3.5' }
  end
end
