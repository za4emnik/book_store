require 'rails_helper'

RSpec.describe OrderItemsController, type: :controller do

  describe '#create' do
    let (:order_item) { FactoryGirl.create(:order_item) }
    subject { post :create }


    it 'quantity should be 1' do
      expect(subject.request.env['action_controller.instance'].current_order.order_items[0].quantity).to eq 1
    end

    it_should_behave_like 'redirect to root page'
  end

  describe '#destroy' do
    let (:order_item) { FactoryGirl.create(:order_item) }
    subject { delete :destroy, params: { id: order_item.id } }

    it 'should delete order item' do
      expect{subject}.to change(OrderItem, :count).by(0)
    end

    it_should_behave_like 'redirect to root page'

  end
end
