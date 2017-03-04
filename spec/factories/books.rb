FactoryGirl.define do
  factory :book do
    title { FFaker::Book::title }
    price { FFaker::Address::building_number }
    description { FFaker::Book::description }
    association :category
  end
end
