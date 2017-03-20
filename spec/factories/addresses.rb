FactoryGirl.define do
  factory :address do
    first_name { FFaker::Name::first_name }
    last_name { FFaker::Name::last_name }
    address { FFaker::Address::street_address }
    city { FFaker::Address::city }
    zip { FFaker::AddressDA::zip_code }
    association :country
    phone { FFaker::PhoneNumberCU::e164_mobile_phone_number }
    association :user
    type 'shipping'
  end
end
