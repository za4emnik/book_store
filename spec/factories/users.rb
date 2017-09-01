require 'ffaker'

FactoryGirl.define do
  factory :user do
    @pass = 'pAssWord123'
    email { FFaker::Internet::email }
    password @pass
    password_confirmation @pass

    trait :admin do
      is_admin true
    end

    factory :admin, traits: [:admin]
  end
end
