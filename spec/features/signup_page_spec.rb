require 'rails_helper'

describe 'signup page', type: :feature do
  context 'when logged' do
    before do
      signin_user
      visit signup_path
    end

    it 'should redirect to home page with failure message' do
      expect(current_path).to eq(root_path)
      expect(page).to have_content(I18n.t('devise.failure.already_authenticated'))
    end
  end

  context 'when guest' do
    before do
      visit signup_path
    end

    it_behaves_like 'functionality for guest'

    it 'should have login link' do
      expect(page).to have_link(I18n.t(:log_in), match: :first)
    end
  end
end
