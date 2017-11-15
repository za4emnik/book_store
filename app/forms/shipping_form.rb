class ShippingForm < AddressBuildForm
  include ActiveModel::Model
  include Virtus.model

  attribute :use_billing_address, Boolean, default: false

  def invalid?
    use_billing_address ? false : super
  end
end
