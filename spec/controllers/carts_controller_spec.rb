require 'rails_helper'

RSpec.describe CartsController, type: :controller do

  describe '#index' do
    subject { get :index }

    FactoryGirl.create(:order)

    it_behaves_like 'given page'

  end

  describe '#update' do

    let!(:order) { FactoryGirl.create(:order) }
    let!(:order_item) { FactoryGirl.create(:order_item, order: order, quantity: 0) }
    let!(:item) { FactoryGirl.attributes_for(:order_item, quantity: 5) }
    subject { put :update, params: { id: order.id, order_items: { order_item.id => item }, order: {:coupon => false} } }

    context 'when logged' do
      login_user

      it 'should update order items' do
        order.order_items << order_item
        expect{ subject }.to change{ OrderItem.find(order_item.id).quantity }.from(order_item.quantity).to(item[:quantity])
      end

      it 'should call #check_coupon if coupon is entered' do
        expect(controller).to receive(:check_coupon)
        subject
      end

      it 'should redirect to home page' do
        subject
        request.env['HTTP_REFERER'] = root_url
        expect(response).to redirect_to(root_url)
      end
    end

    it_behaves_like 'when guest' do
      subject { put :update, params: { id: order.id, order_items: { order_item.id => item }, order: {:coupon => false} } }
    end

  end
end
