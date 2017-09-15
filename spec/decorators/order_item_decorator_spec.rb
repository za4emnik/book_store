require 'rails_helper'

describe OrderItemDecorator, type: :decorator do
  let(:order_item) { FactoryGirl.create(:order_item).decorate }

  context '#quantity_field' do

    it 'should render quantity_field partial' do
      allow(order_item).to receive(:is_cart_page?).and_return true
      expect(h).to receive(:render).with(partial: '/carts/quantity_field', locals: { field: 'field', item: 'item' })
      order_item.quantity_field('field','item')
    end

    it 'should return quantity' do
      allow(order_item).to receive(:is_cart_page?).and_return false
      expect(order_item.quantity_field('field','item')).to have_content(order_item.quantity)
    end
  end

  context '#delete_button' do

    it 'should return delete button' do
      allow(order_item).to receive(:is_cart_page?).and_return true
      expect(order_item.delete_button(order_item)).to have_tag('a', href: h.order_item_path(order_item.id), 'data-method': 'delete')
    end
  end

end