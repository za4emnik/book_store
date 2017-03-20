FactoryGirl.define do
  factory :order_item do
    quantity 5
    association :book
    association :order
  end
end
