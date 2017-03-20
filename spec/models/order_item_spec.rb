require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  subject(:order_item) { FactoryGirl.create :order_item }

  it { should belong_to(:book) }
  it { should belong_to(:order) }

end
