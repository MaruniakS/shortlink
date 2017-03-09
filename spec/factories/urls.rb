FactoryGirl.define do
  factory :url do
    long { Faker::Internet.url }
    created_at { Faker::Number.number(10) }
  end
end