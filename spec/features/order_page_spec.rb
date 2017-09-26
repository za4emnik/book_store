require 'rails_helper'

describe 'order page', type: :feature do

  context 'when logged' do

    let(:country) { FactoryGirl.create(:country) }
    let(:shipping) { FactoryGirl.attributes_for(:order_shipping_address, country_id: country.id) }
    let(:billing) { FactoryGirl.attributes_for(:order_billing_address, country_id: country.id) }
    let(:order) { FactoryGirl.create(:order, user: @user, shipping_address: ShippingAddress.create(shipping), billing_address: BillingAddress.create(billing)) }

    before do
      @user = signin_user
      visit order_path(order)
    end

    it_behaves_like 'functionality for logged user'

    it 'should contain order number' do
      expect(page).to have_content(order.number)
    end

    it 'should contain shipping address' do
      expect(page).to have_content(I18n.t(:shipping_address))
    end

    it 'should contain billing address' do
      expect(page).to have_content(I18n.t(:billing_address))
    end

    it 'should contain shipments' do
      expect(page).to have_content(I18n.t(:shipments))
    end

    it 'should contain payment information' do
      expect(page).to have_content(I18n.t(:payment_information))
    end
  end

  context 'when guest' do

    before do
      visit orders_path
    end

    it 'should redirect to login page with failure message' do
      expect(page).to have_content(I18n.t('devise.failure.unauthenticated'))
      expect(current_path).to eq(new_user_session_path)
    end

    it_behaves_like 'functionality for guest'
  end
end
