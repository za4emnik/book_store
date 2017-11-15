class AddNumberToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :number, :string, default: 'R00000000'
  end
end
