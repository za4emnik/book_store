require 'rails_helper'

describe CategoriesHelper do

  describe '#filter_state' do

    it 'should return humanize string' do
      controller.params[:filter] = 'test_state'
      expect(helper.filter_state).to eq('Test state')
    end
  end

end
