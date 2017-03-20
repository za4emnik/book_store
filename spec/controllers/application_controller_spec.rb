require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do

  let(:order) { FactoryGirl.build_stubbed(:order) }
  subject { ApplicationController.new }

  describe 'current_order' do
    before do
      allow(Order).to receive(:where).and_return order
      #@request.session['order_id']
    end

    it 'should return order' do
      subject.current_order
      expect(subject.instance_variable_get(:@current_order)).to be_a_kind_of(order)
    end

  end
end
