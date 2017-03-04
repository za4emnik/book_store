FactoryGirl.define do
  factory :picture do
    association :book
    image { Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/images/test_image.png'))) }
  end
end
