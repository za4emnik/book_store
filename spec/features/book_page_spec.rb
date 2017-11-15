require 'rails_helper'

describe 'book page', type: :feature do
  let(:picture) { FactoryGirl.create(:picture) }

  context 'when logged' do
    before do
      signin_user
      visit book_path(picture.book)
    end

    it_behaves_like 'functionality for logged user'

    it 'should have review form' do
      expect(page).to have_css('#new_review')
    end

    it 'should show success message if review was submit' do
      review = FactoryGirl.attributes_for(:review, book: picture.book)
      within('#new_review') do
        fill_in 'review[score]', with: review[:score]
        fill_in 'review[title]', with: review[:title]
        fill_in 'review[message]', with: review[:message]
      end
      click_button I18n.t(:post)
      expect(page).to have_content I18n.t('thanks_for_review')
    end
  end

  context 'when guest' do
    before do
      visit book_path(picture.book)
    end

    it_behaves_like 'functionality for guest'
  end

  context 'when logged or guest' do
    before do
      visit book_path(picture.book)
    end

    it 'should have back link' do
      expect(page).to have_link(I18n.t(:back_to_results), match: :first)
    end

    it 'should have book info' do
      expect(page).to have_content(I18n.t(:description))
      expect(page).to have_content(I18n.t(:year_of_publication))
      expect(page).to have_content(I18n.t(:dimensions))
      expect(page).to have_content(I18n.t(:materials))
    end

    it 'should add book to cart' do
      expect { click_button I18n.t(:add_to_cart) }.to change { page.find(:css, '.shop-quantity', match: :first).text.to_i }.by(1)
    end
  end
end
