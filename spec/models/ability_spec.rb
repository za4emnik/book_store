require 'rails_helper'
require 'cancan/matchers'

RSpec.describe Ability, type: :model do

  describe '#initialize' do

    context 'when admin' do
      subject { Ability.new(FactoryGirl.create(:admin)) }

      it{ should be_able_to(:manage, :all) }
    end

    context 'when user' do
      subject { Ability.new(FactoryGirl.create(:user)) }

      it{ should be_able_to(:manage, :Account) }
    end
  end
end
