require 'rails_helper'

describe ApplicationDecorator, type: :decorator do
  let(:order) { FactoryGirl.create(:order, billing_address: BillingAddress.create(billing_address), shipping_address: ShippingAddress.create(shipping_address)).decorate }
  let(:billing_address) { FactoryGirl.attributes_for(:user_billing_address) }
  let(:shipping_address) { FactoryGirl.attributes_for(:user_shipping_address) }

  describe '#edit_link' do
    it 'should return edit link if confirm page' do
      allow(h.request).to receive(:fullpath).and_return('/confirm')
      expect(order.edit_link).to have_tag('a.general-edit', href: h.wizard_path(:address))
    end
  end

  describe '#checkout_index_page?' do
    it 'should return true if checkout index page' do
      allow(h.request).to receive(:fullpath).and_return(h.checkout_index_path)
      expect(order.checkout_index_page?).to be_truthy
    end
  end

  describe '#show_billing_address' do
    it 'should render address partial' do
      expect(h).to receive(:render).with(partial: '/checkout/address', locals: { obj: order.billing_address })
      order.show_billing_address
    end
  end

  describe '#show_shipping_address' do
    it 'should call #show_billing_address if used billing address' do
      allow(order.shipping_address).to receive(:use_billing_address).and_return true
      expect(order).to receive(:show_billing_address)
      order.show_shipping_address
    end

    it 'should render partial if use_billing_address not used' do
      allow(order.shipping_address).to receive(:use_billing_address).and_return false
      expect(h).to receive(:render).with(partial: '/checkout/address', locals: { obj: order.shipping_address })
      order.show_shipping_address
    end
  end
end
