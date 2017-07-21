require 'ffaker'

FactoryGirl.define do
  factory :user do
    @pass = FFaker::Internet::password
    email { FFaker::Internet::email }
    password @pass
    password_confirmation @pass

    trait :admin do
      is_admin true
    end

    factory :admin, traits: [:admin]
  end
end
