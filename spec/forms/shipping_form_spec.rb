require 'rails_helper'

RSpec.describe ShippingForm, type: :model do
  describe '#invalid?' do
    subject { ShippingForm.new }

    it 'should return false if used billing address' do
      allow_any_instance_of(ShippingForm).to receive(:use_billing_address).and_return true
      expect(subject.invalid?).to be_falsey
    end

    it 'should return true if not used billing address' do
      allow_any_instance_of(ShippingForm).to receive(:use_billing_address).and_return false
      expect(subject.invalid?).to be_truthy
    end
  end
end
