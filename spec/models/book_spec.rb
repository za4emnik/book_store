require 'rails_helper'

RSpec.describe Book, type: :model do
  subject(:book) { FactoryGirl.create :book }

  context 'should be presence' do
    it { should validate_presence_of(:title) }

    it { should validate_presence_of(:price) }

    it { should validate_presence_of(:description) }

    it { should validate_presence_of(:category_id) }
  end

  context 'should have associations' do
    it { should have_and_belong_to_many(:authors) }

    it { should have_many(:pictures) }

    it { should belong_to(:category) }
  end

  it { should accept_nested_attributes_for(:pictures) }
end
