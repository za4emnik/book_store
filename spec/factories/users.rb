FactoryGirl.define do
  factory :user do
    email { FFaker::Internet::email }
    password "password"
    password_confirmation "password"

    trait :admin do
      association :is_admin, name: true
    end
  end
end
