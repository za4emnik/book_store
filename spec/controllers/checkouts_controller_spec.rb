require 'rails_helper'

RSpec.describe CheckoutController, type: :controller do
  steps = %w[address delivery payment confirm complete]

  describe '#index' do
    context 'when logged' do
      login_user

      it 'should redirect to #show' do
        get :index
        expect(response).to redirect_to(checkout_path('address'))
      end
    end

    it_behaves_like 'when guest' do
      subject { get :index }
    end
  end

  describe '#show' do
    context 'when logged' do
      login_user

      before do
        allow(controller).to receive(:check_order)
        subject
      end

      steps.each do |step|
        context "#{step} step" do
          subject { get :show, params: { id: :"#{step}" } }

          it_behaves_like 'controller have variables', 'form': nil unless step == 'complete'
          it_behaves_like 'given page'
        end
      end
    end

    context 'when guest' do
      steps.each do |step|
        context "#{step} step" do
          subject { get :show, params: { id: :"#{step}" } }

          it_should_behave_like 'when guest'
        end
      end
    end
  end

  describe '#update' do
    let(:order) { FactoryGirl.create(:order) }

    context 'when logged' do
      login_user

      context 'address step' do
        shipping = FactoryGirl.attributes_for(:order_shipping_address)
        billing = FactoryGirl.attributes_for(:order_billing_address)
        subject { put :update, params: { id: :address, address_form: { billing_form: billing, shipping_form: shipping } } }

        it_behaves_like 'controller have variables', 'form': nil
      end

      context 'delivery step' do
        delivery = FactoryGirl.create(:delivery)
        subject { put :update, params: { id: :delivery, order: { delivery: delivery.id } } }

        it_behaves_like 'controller have variables', 'form': nil
      end

      context 'payment step' do
        cart = FactoryGirl.attributes_for(:cart)
        subject { put :update, params: { id: :payment, cart_form: cart } }

        it_behaves_like 'controller have variables', 'form': nil
      end

      context 'confirm step' do
        subject { put :update, params: { id: :confirm } }

        it_behaves_like 'controller have variables', 'form': nil
      end
    end

    context 'when guest' do
      steps.each do |step|
        context "#{step} step" do
          subject { put :update, params: { id: :"#{step}" } }

          it_should_behave_like 'when guest'
        end
      end
    end
  end
end
