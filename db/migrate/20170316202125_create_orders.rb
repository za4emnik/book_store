class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.references :user
      t.references :delivery
      t.decimal    :total, precision: 8, scale: 2, default: 0
      t.decimal    :subtotal, precision: 8, scale: 2, default: 0
      t.string     :aasm_state
      t.timestamps
    end
  end
end
