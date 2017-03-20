require 'rails_helper'

RSpec.describe Material, type: :model do

  subject(:material) { FactoryGirl.create :material }

  it { should have_and_belong_to_many(:books) }

end
