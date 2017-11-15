require 'rails_helper'

RSpec.describe CreditCard, type: :model do
  describe 'associations' do
    it { should belong_to(:order) }
  end
end
