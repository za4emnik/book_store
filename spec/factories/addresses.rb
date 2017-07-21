FactoryGirl.define do
  factory :address do
    first_name { FFaker::Name::first_name }
    last_name { FFaker::Name::last_name }
    address { FFaker::Address::street_address }
    city { FFaker::Address::city }
    zip 7777777
    association :country
    phone { FFaker::PhoneNumberCU::e164_mobile_phone_number }
    association :user
    type 'ShippingAddress'
    use_billing_address false

  trait :billing_address do
    type 'BillingAddress'
  end

  factory :billing_address, traits: [:billing_address]

  end
end
