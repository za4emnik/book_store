class CreatePictures < ActiveRecord::Migration[5.0]
  def change
    create_table :pictures do |t|
      t.string :name
      t.references :book, index: true
      t.timestamps null: false
    end
  end
end
