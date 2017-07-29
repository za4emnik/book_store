require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'associations' do

    before do
      subject.shipping_address = ShippingAddress.create(FactoryGirl.attributes_for(:address))
      subject.billing_address = BillingAddress.create(FactoryGirl.attributes_for(:billing_address))
    end

    it { should have_one(:shipping_address) }
    it 'should destroy shipping address if user destroy' do
      expect { subject.destroy }.to change { ShippingAddress.count }.by(-1)
    end

    it { should have_one(:billing_address) }
    it 'should destroy billing address if user destroy' do
      expect { subject.destroy }.to change { BillingAddress.count }.by(-1)
    end

    it { should have_many(:reviews) }
    it { should have_many(:orders) }
  end

  describe 'validates' do
    it { should validate_presence_of(:email) }

    it { should allow_value('test@domain.com').for(:email) }
    it { should_not allow_value('testdomain.com').for(:email) }
    it { should_not allow_value('te#st@domain.s').for(:email) }

    it { should_not allow_value('password').for(:password) }
    it { should_not allow_value('pasSword').for(:password) }
    it { should_not allow_value('pasSword').for(:password) }
    it { should_not allow_value('pasS2wo').for(:password) }
    it { should allow_value('passwordS1').for(:password) }
    it { should allow_value('pas5Tsa1').for(:password) }
  end

  describe '#new_with_session' do

    it 'should add email for new users who already has session' do
      email = 'some_email@domain.com'
      params = { password: 'qqqqqqq', password_confirmation: 'qqqqqqq' }
      session = {'devise.facebook_data'=>{ 'extra'=> { 'raw_info'=> { 'email'=> email} } }}
      expect(User.new_with_session(params, session).email).to eq(email)
    end
  end
end
