require 'rails_helper'

RSpec.describe Delivery, type: :model do
  subject(:delivery) { FactoryGirl.create :delivery }

  describe 'should be presence' do
    %w(name interval price).each do |field|
      it { should validate_presence_of(field) }
    end
  end
end
