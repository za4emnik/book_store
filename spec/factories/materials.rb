FactoryGirl.define do
  factory :material do
    name { FFaker::UnitMetric::area_abbr }
  end
end
