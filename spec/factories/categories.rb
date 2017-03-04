FactoryGirl.define do
  factory :category do
    name { FFaker::Skill::specialty }
  end
end
