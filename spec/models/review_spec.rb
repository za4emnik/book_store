require 'rails_helper'
require 'aasm/rspec'

RSpec.describe Review, type: :model do

  describe 'associations' do
    it { should belong_to(:book) }
    it { should belong_to(:user) }
  end

  describe 'validations' do
    %w(title message score user_id book_id).each do |field|
      it { should validate_presence_of(field) }
    end
    it { should validate_length_of(:title).is_at_most(80) }
    it { should allow_value('some title').for(:title) }
    it { should allow_value("!#$%&'*+-\/=?^_`{|}~").for(:title) }
    it { should validate_length_of(:message).is_at_most(500) }
    it { should validate_numericality_of(:score).is_greater_than(0).is_less_than(6) }
  end

  describe 'change of states' do
    it { expect(subject).to transition_from(:unprocessed).to(:approved).on_event(:approve) }
    it { expect(subject).to transition_from(:rejected).to(:approved).on_event(:approve) }
    it { expect(subject).to transition_from(:unprocessed).to(:rejected).on_event(:reject) }
    it { expect(subject).to transition_from(:approved).to(:rejected).on_event(:reject) }
  end
end
