require 'rails_helper'

RSpec.describe HomeController, type: :controller do

  describe 'index' do
    subject { get :index }

    it_behaves_like 'given page'
    it_behaves_like 'controller have variables', { 'latest_books': ActiveRecord::Relation, 'bestsellers': nil }
  end
end
