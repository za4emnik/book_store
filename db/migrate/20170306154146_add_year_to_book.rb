class AddYearToBook < ActiveRecord::Migration[5.0]
  def change
    add_column :books, :year, :integer
  end
end
