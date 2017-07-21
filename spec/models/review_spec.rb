require 'rails_helper'

RSpec.describe Review, type: :model do

  context 'associations' do
    it { should belong_to(:book) }
    it { should belong_to(:user) }
  end

  context 'validations' do
    %w(title message score user_id book_id).each do |field|
      it { should validate_presence_of(field) }
    end
    it { should validate_length_of(:title).is_at_most(80) }
    it { should validate_length_of(:message).is_at_most(500) }
    it { should validate_numericality_of(:score).is_greater_than(0).is_less_than(6) }
    it { should allow_value('some title').for(:title) }
    it { should allow_value("!#$%&'*+-\/=?^_`{|}~").for(:title) }
  end
end
