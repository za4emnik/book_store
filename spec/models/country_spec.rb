require 'rails_helper'

RSpec.describe Country, type: :model do

  context 'scopes' do

    it 'should order ascending by default' do
      %w(Ukraine Andorra Yemen).each do |country|
        FactoryGirl.create(:country, name: country)
      end
      expect(Country.all).to eq(Country.all.order(name: :asc))
    end
  end
end
