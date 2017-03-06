FactoryGirl.define do
  factory :book do
    title { FFaker::Book::title }
    price { FFaker::Address::building_number }
    year { FFaker::AddressCH::postal_code }
    dimensions { FFaker::Book::genre }
    description { FFaker::Book::description }
    association :category
  end
end
