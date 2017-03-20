require 'rails_helper'

RSpec.describe BooksController, type: :controller do

  describe '#show' do
    subject { get :show, params: { id: FactoryGirl.create(:book).id } }
    let(:book) { FactoryGirl.build_stubbed(:book) }
    let(:review) { FactoryGirl.build_stubbed(:review) }
    let(:order_item) { FactoryGirl.build_stubbed(:order_item) }

    it 'response should be 200' do
      expect(subject.status).to eq(200)
    end

    %w(book review order_item).each do |variable|
      it "should have ##{variable} variable" do
        expect(subject.instance_variable_get(:@variable)).kind_of? subject.class
      end
    end

    it '@book should be instance of Book' do
      expect(subject.instance_variable_get(:@book)).kind_of? book.class
    end

    it '@review should be instance of Review' do
      expect(subject.instance_variable_get(:@review)).kind_of? review.class
    end

    it '@order_item should be instance of OrderItem' do
      expect(subject.instance_variable_get(:@order_item)).kind_of? order_item.class
    end
  end

end
