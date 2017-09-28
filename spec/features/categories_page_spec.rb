require 'rails_helper'

describe 'categories page', type: :feature do
  before do
    visit categories_path
  end

  context 'when logged' do
    it_behaves_like 'functionality for logged user', login_before: true, visit_path: '/'
  end

  context 'when guest' do
    it_behaves_like 'functionality for guest', visit_path: '/'
  end

  describe 'sorting criteria' do
    it 'should have a-z link' do
      expect(page).to have_link(I18n.t(:title_a_z), match: :first)
    end

    it 'should have z-a link' do
      expect(page).to have_link(I18n.t(:title_z_a), match: :first)
    end

    it 'should have newest first link' do
      expect(page).to have_link(I18n.t(:newest_first), match: :first)
    end

    it 'should have popular first link' do
      expect(page).to have_link(I18n.t(:popular_first), match: :first)
    end

    it 'should have price low to hight link' do
      expect(page).to have_link(I18n.t(:price_low_hight), match: :first)
    end

    it 'should have price hight to low link' do
      expect(page).to have_link(I18n.t(:price_hight_low), match: :first)
    end
  end
end
