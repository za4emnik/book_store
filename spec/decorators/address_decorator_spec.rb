require 'rails_helper'

describe AddressDecorator, type: :decorator do
  let(:address) { FactoryGirl.create(:order_shipping_address).decorate }

  describe '#show_selected_value' do
    it "should return 'Nothing selected' text" do
      address.country = nil
      expect(address.show_selected_value).to eq(I18n.t(:nothing_selected))
    end

    it 'should return country id if country exist' do
      expect(address.show_selected_value).to eq(address.country.id)
    end
  end
end
