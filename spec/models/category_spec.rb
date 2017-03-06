require 'rails_helper'

RSpec.describe Category, type: :model do
  subject(:category) { FactoryGirl.create :category }

  it { should validate_presence_of(:name) }

  it { should have_many(:books) }
end
