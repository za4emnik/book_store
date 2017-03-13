class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.string     :first_name
      t.string     :last_name
      t.string     :address
      t.string     :city
      t.string     :zip
      t.string     :country
      t.string     :phone
      t.references :user
      t.string     :type
      t.timestamps null: false
   end
  end
end
