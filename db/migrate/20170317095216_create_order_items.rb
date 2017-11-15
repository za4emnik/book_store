class CreateOrderItems < ActiveRecord::Migration[5.0]
  def change
    create_table :order_items do |t|
      t.references :order
      t.references :book
      t.integer    :quantity, default: 0
      t.timestamps null: false
    end
  end
end
