require 'rails_helper'

RSpec.describe Picture, type: :model do
  subject(:picture) { FactoryGirl.create :picture }

  context 'should be presence' do
    it { should validate_presence_of(:image) }

    it { should validate_presence_of(:book_id) }
  end

  it { should belong_to(:book) }
end
