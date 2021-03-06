class CreateDeliveries < ActiveRecord::Migration[5.0]
  def change
    create_table :deliveries do |t|
      t.string  :name
      t.string  :interval
      t.decimal :price, precision: 5, scale: 2
      t.timestamps null: false
    end
  end
end
