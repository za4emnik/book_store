class AddressForm

  include ActiveModel::Model
  include Virtus.model

  attribute :billing_address, BillingForm, default: BillingForm.new
  attribute :shipping_address, ShippingForm, default: ShippingForm.new
  attribute :current_user, User

  validate  :all_addresses_valid

  def save
    if valid?
      persist!
      true
    else
      false
    end
  end

  def all_addresses_valid
    errors.add(:billing_address, billing_address.errors.messages) if billing_address.invalid?
    errors.add(:shipping_address, shipping_address.errors.messages) if shipping_address.invalid?
  end


  private

  def persist!
    create_or_update('billing_address')
    create_or_update('shipping_address')
  end

  def create_or_update(type)
    unless current_user.public_send(type).present?
      current_user.public_send("#{type}=", type.classify.constantize.new(public_send(type).attributes))
    end
    current_user.public_send(type).update_attributes(public_send(type).attributes)
  end
end
