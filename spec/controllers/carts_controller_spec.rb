require 'rails_helper'

RSpec.describe CartsController, type: :controller do

  let(:order_item_params) { FactoryGirl.attributes_for(:order_item).stringify_keys }
  let(:order) { FactoryGirl.create(:order) }

  describe 'PUT #update' do

    it 'receives update order_items' do
      allow(OrderItem).to receive(:update)
      expect(OrderItem).to receive(:update)
      put :update, id: order.id, order_items: order_item_params
    end
  end

end
