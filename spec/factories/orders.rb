FactoryGirl.define do
  factory :order do
    total 100
    subtotal 200
    association :user
    association :delivery
    association :cart
  end
end
