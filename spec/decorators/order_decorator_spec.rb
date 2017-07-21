require 'rails_helper'

describe OrderDecorator, type: :decorator do
  let(:coupon) { FactoryGirl.build(:coupon) }
  let(:delivery) { FactoryGirl.build(:delivery) }
  let(:order) { FactoryGirl.create(:order, coupon: coupon, delivery: delivery).decorate }

  context '#summary_coupon' do

    it 'should return coupon info' do
      expect(order.summary_coupon).to have_content(coupon.value)
    end
  end

  context '#summary_delivery' do

    it 'should return delivery info' do
      expect(order.summary_delivery).to have_content(delivery.price)
    end
  end

  context '#delete_button_header' do

    it 'should return close button' do
      allow(order).to receive(:is_cart_page?).and_return true
      expect(order.delete_button_header).to have_tag('th.col-close')
    end
  end

end
