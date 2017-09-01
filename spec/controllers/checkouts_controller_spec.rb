require 'rails_helper'

RSpec.describe CheckoutController, type: :controller do

  steps = %w(address delivery payment confirm complete)

  describe '#index' do
    context 'when logged' do
      login_user

      it 'should redirect to #show' do
        get :index
        expect(response).to redirect_to(checkout_path('address'))
      end
    end

    it_should_behave_like 'when guest' do
      subject { get :index }
    end
  end

  describe '#show' do
    let(:order) { FactoryGirl.create(:order) }

    context 'when logged' do
      login_user

      steps.each do |step|
        context "#{step} step" do
          subject { get :show, params: { id: :"#{step}" } }

          it_should_behave_like 'should have @form'
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
        address = FactoryGirl.attributes_for(:order_shipping_address)
        subject { put :update, params: { id: :address, address_form: { billing_form: address, shipping_form: address } } }

        it_should_behave_like 'should have @form'
      end

      context 'delivery step' do
        delivery = FactoryGirl.create(:delivery)
        subject { put :update, params: { id: :delivery, order: { delivery: delivery.id } } }

        it_should_behave_like 'should have @form'
      end

      context 'payment step' do
        cart = FactoryGirl.attributes_for(:cart)
        subject { put :update, params: { id: :payment, cart_form: cart } }

        it_should_behave_like 'should have @form'
      end

      context 'confirm step' do
        subject { put :update, params: { id: :confirm } }

        it_should_behave_like 'should have @form'
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
