FactoryGirl.define do
  factory :order_item do
    association :book
    association :order
  end
end
