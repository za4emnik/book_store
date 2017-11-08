require 'rails_helper'
include Shoulda::Matchers::ActionController

RSpec.describe ReviewsController, type: :controller do
  describe '#create' do
    let (:book) { FactoryGirl.create(:book) }
    subject { post :create, params: { review: FactoryGirl.attributes_for(:review, book_id: book) } }

    context 'when logged' do
      login_user

      before do
        subject
      end

      it 'should set success mesage' do
        expect(flash[:success]).to be
      end

      it 'should redirect to book page' do
        expect(subject).to redirect_to(book_path(book))
      end
    end

    context 'when guest' do
      it 'should redirect to login page' do
        expect(subject).to redirect_to(new_user_session_path)
      end
    end
  end
end
