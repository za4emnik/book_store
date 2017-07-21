require 'rails_helper'

RSpec.describe Picture, type: :model do

  context 'associations' do
    it { should belong_to(:book) }
  end

  context 'validates' do
    it { should validate_presence_of(:image) }
    it { should validate_presence_of(:book_id) }
  end
end
