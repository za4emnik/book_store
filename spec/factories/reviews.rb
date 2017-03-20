FactoryGirl.define do
  factory :review do
    title { FFaker::Book::title }
    score 5
    message { FFaker::CheesyLingo::sentence }
    association :book
    association :user
  end
end
