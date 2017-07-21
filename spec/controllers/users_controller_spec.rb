require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe '#edit' do
    subject { get :edit }

    context 'when logged' do
      login_user

      %w(billing_address shipping_address).each do |variable|
        it "should have @#{variable} variable" do
          expect(subject.request.env['action_controller.instance'].current_user.public_send(variable)).kind_of? Address
        end
      end

      it_should_behave_like 'given page'
    end

    context 'when guest' do
      it_should_behave_like 'when guest'
    end
  end

  describe '#update_shipping' do
    let(:address) { FactoryGirl.attributes_for(:address) }
    subject { patch :update_shipping, params: { user_id: 1, shipping_address: address, billing_address: address } }

    context 'when logged' do
      login_user

      it 'should update shipping address' do
        expect(subject.request.env['action_controller.instance'].current_user.shipping_address.attributes.symbolize_keys.delete_if{ |item| address.exclude?(item) }).to eq(address)
      end

      it 'should redirect to settings page' do
        expect(subject).to redirect_to(settings_path)
      end
    end

    context 'when guest' do
      it_should_behave_like 'when guest'
    end
  end

  describe '#update_billing' do
    let(:address) { FactoryGirl.attributes_for(:billing_address) }
    subject { patch :update_billing, params: { user_id: 1, shipping_address: address, billing_address: address } }

    context 'when logged' do
      login_user

      it 'should update shipping address' do
        expect(subject.request.env['action_controller.instance'].current_user.billing_address.attributes.symbolize_keys.delete_if{ |item| address.exclude?(item) }).to eq(address)
      end

      it 'should redirect to settings page' do
        expect(subject).to redirect_to(settings_path)
      end
    end

    context 'when guest' do
      it_should_behave_like 'when guest'
    end
  end

  describe '#update_email' do
    let(:user) { FactoryGirl.attributes_for(:user) }
    subject { patch :update_email, params: { user_id: 1, user: user } }

    context 'when logged' do
      login_user

      it 'should update user email' do
        expect(subject.request.env['action_controller.instance'].current_user.email).to eq(user[:email])
      end

      it 'should redirect to settings page' do
        expect(subject).to redirect_to(settings_path)
      end
    end

    context 'when guest' do
      it_should_behave_like 'when guest'
    end
  end

  describe '#update_password' do
    let(:user) { FactoryGirl.attributes_for(:user) }
    subject { patch :update_email, params: { user_id: 1, user: user } }

    context 'when logged' do
      login_user

      it 'should update password' do
        expect(subject.request.env['action_controller.instance'].current_user.password).to eq(user[:password])
      end

      it 'should redirect to settings page' do
        expect(subject).to redirect_to(settings_path)
      end
    end

    context 'when guest' do
      it_should_behave_like 'when guest'
    end
  end

  describe '#destroy' do
    subject { delete :destroy, params: { id: 1 } }

    context 'when logged' do
      login_user

      it 'should delete user' do
        expect{subject}.to change(User, :count).by(-1)
      end

      it_should_behave_like 'redirect to root page'
    end

    context 'when guest' do
      it_should_behave_like 'when guest'
    end
  end
end
