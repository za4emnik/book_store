require 'rails_helper'
include Shoulda::Matchers::ActionController

RSpec.describe ReviewsController, type: :controller do

  describe '#create' do
    let (:book) { FactoryGirl.build_stubbed(:book) }
    subject { post :create, params: { review: FactoryGirl.attributes_for(:review, book_id: book) } }

    context 'when logged' do
      login_user

      it 'shoul redirect to book page' do
        expect(subject).to redirect_to(book_path(id: book.id))
      end
    end

    context 'when guest' do
      it 'shoul redirect to login page' do
        expect(subject).to redirect_to(new_user_session_path)
      end
    end

  end
end
