FactoryGirl.define do
  factory :category do
    name { FFaker::Skill.specialty }

    trait :mobile do
      name { 'mobile' }
    end
  end
end
