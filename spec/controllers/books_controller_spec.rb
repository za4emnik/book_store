require 'rails_helper'

RSpec.describe BooksController, type: :controller do

  describe '#show' do
    subject { get :show, params: { id: FactoryGirl.create(:book).id } }

    before do
      subject
    end

    it_behaves_like 'controller have variables', {'book': Book, 'review': Review, 'order_item': OrderItem}
    it_behaves_like 'given page'
  end
end
