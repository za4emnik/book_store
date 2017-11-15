require 'rails_helper'

describe UserDecorator, type: :decorator do
  let(:user) { FactoryGirl.create(:user).decorate }
  let(:order) { FactoryGirl.create(:order, user_id: user.id) }
  let(:book) { FactoryGirl.create(:book) }
  let!(:order_item) { FactoryGirl.create(:order_item, book_id: book.id, order_id: order.id) }

  describe '#verified_reviewer' do
    it 'should retun \'verified reviewer\' if the user bought a book' do
      expect(user.verified_reviewer(book.id)).to have_content(I18n.t(:verified_reviewer))
    end
  end
end
