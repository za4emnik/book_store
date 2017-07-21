require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  describe '#index' do
    login_user
    subject { get :index }

    it_should_behave_like 'given page'

  end

  describe '#show' do
    login_user
    subject { get :show, params: { id: FactoryGirl.create(:order).id } }

    it_should_behave_like 'given page'

  end
end
