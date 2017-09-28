require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe '#edit' do
    subject { get :edit }

    context 'when logged' do
      login_user

      it_behaves_like 'controller have variables', 'billing_address': BillingForm, 'shipping_address': ShippingForm
      it_behaves_like 'given page'
    end

    context 'when guest' do
      it_should_behave_like 'when guest'
    end
  end

  describe '#update' do
    context 'when logged' do
      login_user

      context 'shipping form' do
        let(:address) { FactoryGirl.attributes_for(:user_shipping_address, country_id: 1) }
        subject { patch :update, params: { user_id: FactoryGirl.create(:user).id, shipping_form: address } }

        it 'should update shipping address' do
          subject
          expect(controller.current_user.shipping_address.attributes.symbolize_keys.delete_if { |item| address.exclude?(item) }).to eq(address)
        end

        it 'should redirect to settings page' do
          expect(subject).to redirect_to(settings_path)
        end
      end

      context 'billing form' do
        let(:address) { FactoryGirl.attributes_for(:user_billing_address, country_id: 1) }
        subject { patch :update, params: { user_id: 1, billing_form: address } }

        it 'should update billing address' do
          subject
          expect(controller.current_user.billing_address.attributes.symbolize_keys.delete_if { |item| address.exclude?(item) }).to eq(address)
        end

        it 'should redirect to settings page' do
          expect(subject).to redirect_to(settings_path)
        end
      end

      context 'email form' do
        let(:user) { FactoryGirl.attributes_for(:user) }
        subject { patch :update, params: { user_id: 1, email_form: user } }

        it 'should update user email' do
          subject
          expect(controller.current_user.email).to eq(user[:email])
        end

        it 'should redirect to settings page' do
          expect(subject).to redirect_to(settings_path)
        end
      end

      context 'password form' do
        let(:user) { User.new(FactoryGirl.attributes_for(:user)) }
        subject { patch :update, params: { user_id: 1, password_form: user.attributes } }

        it 'should update password' do
          subject
          expect(controller.current_user.valid_password?(user.password)).to be_truthy
        end
      end
    end

    context 'when guest' do
      subject { patch :update, params: { user_id: 1, shipping_form: {} } }
      it_should_behave_like 'when guest'
    end
  end

  describe '#destroy' do
    subject { delete :destroy, params: { id: controller.current_user.id } }

    context 'when logged' do
      login_user

      it 'should delete user' do
        expect { subject }.to change(User, :count).by(-1)
      end

      it_should_behave_like 'redirect to root page'
    end

    context 'when guest' do
      subject { patch :update, params: { user_id: 1 } }
      it_should_behave_like 'when guest'
    end
  end
end
