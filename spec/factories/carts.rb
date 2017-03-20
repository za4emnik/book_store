FactoryGirl.define do
  factory :cart do
    number { FFaker::PhoneNumber::imei }
    name { FFaker::NatoAlphabet::alphabetic_code }
    date 11/17
    cvv 123
    association :order
  end
end
