FactoryGirl.define do
  factory :delivery do
    name { FFaker::UnitMetric.area_abbr }
    interval { FFaker::AddressGR.neighborhood }
    price 100
  end
end
