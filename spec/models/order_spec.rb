require 'rails_helper'

RSpec.describe Order, type: :model do
  subject(:order) { FactoryGirl.create :order }

  it { should have_one(:coupon) }
  it { should have_one(:cart) }
  it { should have_many(:order_items) }
  it { should belong_to(:user) }
  it { should belong_to(:delivery) }
end
