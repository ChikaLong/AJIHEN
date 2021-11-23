FactoryBot.define do
  factory :comment do
    user
    post
    comment { 'testcomment' }
  end
end
