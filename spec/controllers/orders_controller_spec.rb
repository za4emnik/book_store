require 'rails_helper'

RSpec.describe OrdersController, type: :controller do

  describe '#index' do
    subject { get :index }

    context 'when logged' do
      login_user
      let!(:delivered_order) { FactoryGirl.create(:order, user: controller.current_user, aasm_state: 'delivered') }

      before do
        subject
        FactoryGirl.create(:order, user: controller.current_user, aasm_state: 'pending')
      end

      it_should_behave_like 'given page'

      it 'should return orders where state isn\'t pending' do
        expect(controller.instance_variable_get(:@orders)).to eq([delivered_order])
      end
    end

    context 'when guest' do
      it_should_behave_like 'when guest'
    end
  end

  describe '#show' do
    let(:order) { FactoryGirl.create(:order) }
    subject { get :show, params: { id: order.id } }

    context 'when logged' do
      login_user

      before do
        subject
        FactoryGirl.create(:order, user: controller.current_user, aasm_state: 'pending')
      end

      it_should_behave_like 'given page'

      it 'should return order' do
        expect(controller.instance_variable_get(:@order)).to eq(order)
      end
    end

    context 'when guest' do
      it_should_behave_like 'when guest'
    end
  end

end
