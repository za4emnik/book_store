require 'rails_helper'

RSpec.describe StepShowService do

  context '#initialize' do

    order = FactoryGirl.create(:order)
    subject { StepShowService.new(:address, order, 'session') }

    %w(step order user session).each do |variable|
      it "should have ##{variable} variable" do
        expect(subject.instance_variable_get("@#{variable}".to_sym)).not_to be_nil
      end
    end

    it '@user should be decorated' do
      expect(subject.instance_variable_get(:@user)).to be_decorated
    end
  end

  context '#form' do

    [:address, :delivery, :payment, :confirm, :complete].each do |step|
      it "should call ##{step.to_s} method" do
        order = FactoryGirl.create(:order)
        obj = StepShowService.new(step, order, 'session')
        expect(obj).to receive(step)
        obj.form
      end
    end
  end

  context '#address' do
    user = FactoryGirl.create(:user)
    user.shipping_address = ShippingAddress.create(FactoryGirl.attributes_for(:address))
    user.billing_address = BillingAddress.create(FactoryGirl.attributes_for(:billing_address))
    order = FactoryGirl.create(:order, user: user)
    subject { StepShowService.new(:address, order, 'session') }

    it 'should set shipping address to form' do
      allow_any_instance_of(AddressForm).to receive(:shipping_address).and_return(user.shipping_address)
      expect(subject.address.shipping_address).to eq(user.shipping_address)
    end

    it 'should set billing address to form' do
      allow_any_instance_of(AddressForm).to receive(:billing_address).and_return(user.billing_address)
      expect(subject.address.billing_address).to eq(user.billing_address)
    end

    it 'should return AddressForm instance' do
      expect(subject.address).to be_a_kind_of(AddressForm)
    end
  end

  context '#delivery' do
    5.times { FactoryGirl.create(:delivery) }
    subject { StepShowService.new(:address, FactoryGirl.create(:order), 'session') }

    it 'should return all deliveries' do
      expect(subject.delivery).to eq(Delivery.all)
    end
  end

  context '#payment' do
    order = FactoryGirl.create(:order)
    subject { StepShowService.new(:address, order, 'session') }

    it 'should set order to form' do
      allow_any_instance_of(CartForm).to receive(:order).and_return(order)
      expect(subject.payment.order).to eq(order)
    end

    it 'should return CartForm instance' do
      expect(subject.payment).to be_a_kind_of(CartForm)
    end
  end

  context '#confirm' do
    order = FactoryGirl.create(:order)
    session = { steps_taken?: nil }
    subject { StepShowService.new(:address, order, session) }

    it 'should set :steps_taken? flag to true' do
      expect{ subject.confirm }.to change{ subject.instance_variable_get(:@session)[:steps_taken?] }.from(nil).to(true)
    end

    it 'should return @user' do
      expect(subject.confirm).to eq(subject.instance_variable_get(:@user))
    end
  end

  context '#complete' do

    before do
      2.times { user.orders << FactoryGirl.create(:order, aasm_state: 'pending') }
    end

    let(:user) { FactoryGirl.create(:user) }
    let(:delivered_order) { user.orders << FactoryGirl.create(:order, aasm_state: 'delivered') }
    subject { StepShowService.new(:address, user.orders[0], 'session') }

    it 'should return last order where state is not \'pending\'' do
      allow_any_instance_of(Order).to receive(:decorate).and_return(delivered_order)
      expect(subject.complete).to eq(delivered_order)
    end

    it 'should return decorate order' do
      delivered_order
      expect(subject.complete).to be_decorated
    end
  end
end
