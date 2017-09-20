require 'rails_helper'

RSpec.describe Material, type: :model do

  context 'associations' do
    it { should have_and_belong_to_many(:books) }
  end
end
