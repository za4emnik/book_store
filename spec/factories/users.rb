FactoryGirl.define do
  factory :user do
    email { FFaker::Internet::email }
    password "password"
    password_confirmation "password"

    trait :admin do
      is_admin true
    end

    factory :admin, traits: [:admin]
  end
end
