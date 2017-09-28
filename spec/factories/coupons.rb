FactoryGirl.define do
  factory :coupon do
    code { FFaker::Guid.guid }
    value 100
    association :order
  end
end
