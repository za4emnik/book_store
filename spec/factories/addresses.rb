FactoryGirl.define do
  factory :address do
    first_name { FFaker::Name::first_name }
    last_name { FFaker::Book::last_name }
    address { FFaker::Address::street_address }
    city { FFaker::Address::city }
    zip { FFaker::Address::zip_code }
    association :country
    phone { FFaker::PhoneNumber::phone_number }
    association :user
    type 'shipping'
  end
end
