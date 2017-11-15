require 'rails_helper'

describe 'login page', type: :feature do
  context 'when logged' do
    before do
      signin_user
      visit login_path
    end

    it 'should redirect to home page with failure message' do
      expect(current_path).to eq(root_path)
      expect(page).to have_content(I18n.t('devise.failure.already_authenticated'))
    end
  end

  context 'when guest' do
    before do
      visit login_path
    end

    it_behaves_like 'functionality for guest'

    it 'should show failure message if incorrect authentication data is entered' do
      within('#new_user') do
        fill_in 'user[email]', with: 'testcustom@email.com'
        fill_in 'user[password]', with: 'testpassword12345'
      end
      click_button I18n.t(:log_in)
      expect(page).to have_content I18n.t('devise.failure.invalid', authentication_keys: 'Email')
    end

    it 'should redirect to home page if user logged' do
      signin_user
      expect(current_path).to eq(root_path)
      expect(page).to have_content(I18n.t('devise.sessions.signed_in'))
    end

    it 'should redirect to admin page if admin logged' do
      signin_admin
      expect(current_path).to eq(rails_admin_path)
    end
  end
end
