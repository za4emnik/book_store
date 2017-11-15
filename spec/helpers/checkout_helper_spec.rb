require 'rails_helper'

describe CheckoutHelper do
  describe '#current_step' do
    it 'should return active class on current step' do
      assign(:step, 'some_step')
      expect(helper.current_step('some_step')).to eq('active')
    end
  end

  describe '#checked_delivery?' do
    it 'should return true if delivery was selected' do
      controller.params[:delivery_id] = 1
      expect(helper.checked_delivery?(1)).to be
    end
  end
end
