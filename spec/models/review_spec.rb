require 'rails_helper'

RSpec.describe Review, type: :model do
  subject(:review) { FactoryGirl.create :review }

  describe 'should presence' do
    %w(title message score user_id book_id).each do |field|
      it { should validate_presence_of(field) }
    end
  end

  it { should validate_length_of(:title).is_at_most(80) }
  it { should validate_length_of(:message).is_at_most(500) }
end
