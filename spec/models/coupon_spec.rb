require 'rails_helper'

RSpec.describe Coupon, type: :model do
  subject(:coupon) { FactoryGirl.create :coupon }

  describe 'should presence' do
    %w(code value).each do |field|
      it { should validate_presence_of(field) }
    end
  end

  it { should belong_to(:order) }
end
