require 'rails_helper'

describe UserDecorator, type: :decorator do
  let(:shipping_address) { ShippingAddress.new(FactoryGirl.attributes_for(:address)) }
  let(:billing_address) { BillingAddress.new(FactoryGirl.attributes_for(:billing_address)) }
  let(:user) { FactoryGirl.create(:user, billing_address: billing_address, shipping_address: shipping_address).decorate }

  context '#show_billing_address' do

    it 'should render address partial' do
      expect(h).to receive(:render).with(partial: '/checkout/address', locals: { obj: user.billing_address })
      user.show_billing_address
    end
  end

  context 'show_shipping_address' do

    it 'should call #show_billing_address' do
      allow(user.shipping_address).to receive(:use_billing_address).and_return true
      expect(user).to receive(:show_billing_address)
      user.show_shipping_address
    end

    it 'should render address partial' do
      expect(h).to receive(:render).with(partial: '/checkout/address', locals: { obj: user.shipping_address })
      user.show_shipping_address
    end
  end

end
