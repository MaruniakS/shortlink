FactoryGirl.define do
  factory :url do
    long { Faker::Lorem.word }
    created_by { Faker::Number.number(10) }
  end
end