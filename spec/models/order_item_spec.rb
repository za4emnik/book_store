require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  context 'associations' do
    it { should belong_to(:book) }
    it { should belong_to(:order) }
  end
end
