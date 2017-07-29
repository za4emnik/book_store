class CreateCarts < ActiveRecord::Migration[5.0]
  def change
    create_table :carts do |t|
      t.integer    :number
      t.string     :name
      t.string     :date
      t.integer    :cvv
      t.references :order
      t.timestamps null: false
    end
  end
end
