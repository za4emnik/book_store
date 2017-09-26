require 'rails_helper'

describe 'settings page', type: :feature do

  context 'when logged' do

    before do
      signin_user
      visit settings_path
    end

    it_behaves_like 'functionality for logged user'

    it 'should contain shipping address' do
      expect(page).to have_content(I18n.t(:shipping_address))
    end

    it 'should contain billing address' do
      expect(page).to have_content(I18n.t(:billing_address))
    end

    describe 'remove account' do

      it 'should have remove account button' do
        expect(page).to have_content(I18n.t(:remove_account))
      end

      it 'redirect to home page if account was removed' do
        find('#delete-account-button').click
        expect(current_path).to eq(root_path)
      end
    end
  end

  context 'when guest' do

    before do
      visit settings_path
    end

    it 'should redirect to login page with failure message' do
      expect(page).to have_content(I18n.t('devise.failure.unauthenticated'))
      expect(current_path).to eq(new_user_session_path)
    end
  end
end
