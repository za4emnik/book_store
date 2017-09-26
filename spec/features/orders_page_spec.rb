require 'rails_helper'

describe 'orders page', type: :feature do

  context 'when logged' do

    before do
      @user = signin_user
      visit orders_path
    end

    let(:order) { FactoryGirl.create(:order) }

    it_behaves_like 'functionality for logged user'

    describe 'sorting criteria' do

      it 'should have all link' do
        expect(page).to have_link(I18n.t(:all), match: :first)
      end

      it 'should have waiting for processing link' do
        expect(page).to have_link(I18n.t(:waiting_for_processing), match: :first)
      end

      it 'should have in progress link' do
        expect(page).to have_link(I18n.t(:in_progress), match: :first)
      end

      it 'should have in delivery link' do
        expect(page).to have_link(I18n.t(:in_delivery), match: :first)
      end

      it 'should have delivered link' do
        expect(page).to have_link(I18n.t(:delivered), match: :first)
      end
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
  end
end
