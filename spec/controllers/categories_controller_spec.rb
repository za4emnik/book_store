require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  before do
    subject
  end

  describe '#index' do
    subject { get :index, params: { filter: nil } }

    it_behaves_like 'controller have variables', 'books': ActiveRecord::Relation, 'books_count': Integer
    it_behaves_like 'given page'
  end

  describe '#show' do
    subject { get :show, params: { id: FactoryGirl.create(:category).id } }

    it_behaves_like 'controller have variables', 'books': ActiveRecord::Relation, 'books_count': Integer
    it_behaves_like 'given page'
  end
end
