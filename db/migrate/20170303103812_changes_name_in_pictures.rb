class ChangesNameInPictures < ActiveRecord::Migration[5.0]
  def change
    rename_column :pictures, :name, :image
  end
end
