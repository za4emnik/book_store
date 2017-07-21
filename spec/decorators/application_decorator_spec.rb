require 'rails_helper'

describe ApplicationDecorator, type: :decorator do
  let(:order) { FactoryGirl.build_stubbed(:order).decorate }

  context '#edit_link' do

    it 'should return edit link if confirm page' do
      allow(h.request).to receive(:fullpath).and_return('/confirm')
      expect(order.edit_link).to have_tag('a.general-edit', href: h.wizard_path(:address))
    end
  end

  context '#is_cart_page?' do

    it 'should return true if cart page' do
      allow(h.request).to receive(:fullpath).and_return(h.cart_page_path)
      expect(order.is_cart_page?).to be_truthy
    end
  end

end
