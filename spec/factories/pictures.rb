FactoryGirl.define do
  factory :picture do
    image { Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/images/test_image.png'))) }
    association :book
  end
end
