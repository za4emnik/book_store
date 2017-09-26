require 'rails_helper'

describe 'home page', type: :feature do

  before do
    visit root_path
  end

  context 'when logged' do
    it_behaves_like 'functionality for logged user', login_before: true, visit_path: '/'
  end

  context 'when guest' do
    it_behaves_like 'functionality for guest', visit_path: '/'
  end

  context 'when logged or guest' do
    it 'get started button should lead to categories' do
      click_button I18n.t(:get_started)
      expect(current_path).to eql(categories_path)
    end

    it 'should have best sellers section' do
      expect(page).to have_content(I18n.t(:best_sellers))
    end
  end
end
