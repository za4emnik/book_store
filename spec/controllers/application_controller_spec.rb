require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  let(:order) { FactoryGirl.create(:order) }

  describe 'cancan access denied' do

    controller do
      def index
        raise CanCan::AccessDenied
      end
    end

    before do
      get :index
    end

    it_should_behave_like 'redirect to root page'

    it 'should alert exeption' do
      expect(flash[:notice]).to be
    end
  end

  describe '#after_sign_in_path_for' do
    it 'should return admin root path' do
      admin = FactoryGirl.create(:admin)
      expect(subject.after_sign_in_path_for(admin)).to eq rails_admin_path
    end

    it 'should return root path' do
      user = FactoryGirl.create(:user)
      expect(subject.after_sign_in_path_for(user)).to eq root_path
    end
  end

  describe '#current_order' do

    it 'should return order' do
      subject.current_order
      expect(subject.instance_variable_get(:@current_order)).to be_a_kind_of(Order)
    end

    it 'should return order by session' do
      @request.session['order_id'] = order.id
      expect(subject.current_order).to eq(order)
    end
  end
end
