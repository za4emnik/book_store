class AddUseBillingAddressToAddresses < ActiveRecord::Migration[5.0]
  def change
    add_column :addresses, :use_billing_address, :boolean, default: false
  end
end
