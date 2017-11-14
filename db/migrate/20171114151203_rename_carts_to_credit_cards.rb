class RenameCartsToCreditCards < ActiveRecord::Migration[5.0]
  def change
    rename_table :carts, :credit_cards
  end
end
