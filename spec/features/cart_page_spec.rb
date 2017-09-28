require 'rails_helper'

describe 'cart page', type: :feature do
  context 'when logged' do
    before do
      signin_user
      add_book_to_cart
      visit carts_path
    end

    it_behaves_like 'functionality for logged user'

    it 'should redirect to address step if click checkout button' do
      click_button('Checkout', match: :first)
      expect(current_path).to eq(checkout_path(:address))
    end
  end

  context 'when guest' do
    before do
      add_book_to_cart
      visit carts_path
    end

    it_behaves_like 'functionality for guest'

    it 'should redirect to login page if click checkout button' do
      click_button(I18n.t(:checkout), match: :first)
      expect(current_path).to eq(new_user_session_path)
    end
  end

  context 'when logged or guest' do
    context 'when have items' do
      before do
        add_book_to_cart
        visit carts_path
      end

      it 'should have product' do
        expect(page).to have_content(I18n.t(:product))
      end

      it 'should have price' do
        expect(page).to have_content(I18n.t(:price))
      end

      it 'should have quantity' do
        expect(page).to have_content(I18n.t(:quantity))
      end

      it 'should have subtotal' do
        expect(page).to have_content(I18n.t(:subtotal))
      end
    end

    context 'when cart is empty' do
      before do
        visit carts_path
      end

      it 'should show empty message' do
        expect(page).to have_content(I18n.t(:cart_empty))
      end
    end
  end
end
