class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.string     :title
      t.string     :score
      t.text       :message
      t.references :book
      t.references :user
      t.string     :aasm_state
      t.timestamps
    end
  end
end
