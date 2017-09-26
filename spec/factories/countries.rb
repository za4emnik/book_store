FactoryGirl.define do
  factory :country do
    name { FFaker::AddressUA::country }
  end
end
