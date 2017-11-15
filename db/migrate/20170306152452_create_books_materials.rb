class CreateBooksMaterials < ActiveRecord::Migration[5.0]
  def change
    create_table :books_materials, id: false do |t|
      t.integer :book_id
      t.integer :material_id
      t.timestamps null: false
    end
  end
end
