class AddDimensionsToBook < ActiveRecord::Migration[5.0]
  def change
    add_column :books, :dimensions, :string
  end
end
