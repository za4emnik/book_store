FactoryGirl.define do
  factory :cart do
    number '12345678901234567'
    name { FFaker::NatoAlphabet::alphabetic_code }
    date '11/18'
    cvv 123
  end
end
