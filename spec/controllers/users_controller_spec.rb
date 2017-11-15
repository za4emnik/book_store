require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe '#edit' do
    subject { get :edit }

    context 'when logged' do
      login_user

      it_behaves_like 'controller have variables', 'billing_address': BillingForm, 'shipping_address': ShippingForm, 'password_form': PasswordForm
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
        subject { patch :update, params: { user_id: controller.current_user.id, addresses: { shipping_form: address } } }

        before do
          allow(controller.current_user).to receive(:shipping_address).and_return(FactoryGirl.create(:user_shipping_address, country_id: 2))
        end

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
        subject { patch :update, params: { user_id: controller.current_user.id, addresses: { billing_form: address } } }

        before do
          allow(controller.current_user).to receive(:billing_address).and_return(FactoryGirl.create(:user_billing_address, country_id: 2))
        end

        it 'should update billing address' do
          subject
          expect(controller.current_user.billing_address.attributes.symbolize_keys.delete_if { |item| address.exclude?(item) }).to eq(address)
        end

        it 'should redirect to settings page' do
          expect(subject).to redirect_to(settings_path)
        end
      end

      context 'email form' do
        let(:user_attributes) { FactoryGirl.attributes_for(:user) }
        subject { patch :update, params: { user_id: controller.current_user.id, email_form: user_attributes } }

        it 'should update user email' do
          subject
          expect(controller.current_user.email).to eq(user_attributes[:email])
        end

        it 'should redirect to settings page' do
          expect(subject).to redirect_to(settings_path)
        end
      end

      context 'password form' do
        let(:user_attributes) { User.new(FactoryGirl.attributes_for(:user)) }
        subject { patch :update, params: { user_id: controller.current_user.id, password_form: user_attributes.attributes } }

        it 'should update password' do
          subject
          expect(controller.current_user.valid_password?(user_attributes.password)).to be_truthy
        end
      end
    end

    context 'when guest' do
      subject { patch :update, params: { user_id: 1, shipping_form: {} } }
      it_should_behave_like 'when guest'
    end
  end

  describe '#destroy' do
    context 'when logged' do
      login_user
      subject { delete :destroy, params: { id: controller.current_user.id } }

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
