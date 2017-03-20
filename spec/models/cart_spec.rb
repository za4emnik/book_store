require 'rails_helper'

RSpec.describe Cart, type: :model do
  subject(:cart) { FactoryGirl.create :cart }

  describe 'should presence' do
    %w(number name date cvv order_id).each do |field|
      it { should validate_presence_of(field) }
    end
  end
end
