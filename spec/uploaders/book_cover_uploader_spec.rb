require 'carrierwave/test/matchers'
require 'rails_helper'

describe BookCoverUploader do
  include CarrierWave::Test::Matchers

  let(:picture) { double('picture') }
  let(:uploader) { BookCoverUploader.new(picture, :image) }

  before do
    allow(picture).to receive(:id).and_return(11)
    BookCoverUploader.enable_processing = true
    File.open(File.join(Rails.root, '/spec/fixtures/images/test_image.png')) { |f| uploader.store!(f) }
  end

  after do
    BookCoverUploader.enable_processing = false
    uploader.remove!
  end

  it 'makes the image readable only to the owner and not executable' do
    expect(uploader).to have_permissions(0o644)
  end

  it 'has the correct format' do
    expect(uploader).to be_format('png')
  end
end
