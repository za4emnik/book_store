require 'rails_helper'

RSpec.describe CartForm, type: :model do

  describe 'should presence' do
    %w(number name date cvv order).each do |field|
      it { should validate_presence_of(field) }
    end
  end

  describe 'length validate' do
    it { should validate_length_of(:name).is_at_most(50) }
    it { should validate_length_of(:cvv).is_at_least(3).is_at_most(4) }
    it { should validate_length_of(:number).is_at_most(21) }
  end
end
