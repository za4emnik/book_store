class Book < ApplicationRecord
  validates :title, :price, :description, :category_id, presence: true

  has_and_belongs_to_many :authors
  has_and_belongs_to_many :materials
  belongs_to :category
  has_many :pictures
  has_many :reviews, -> { where(published: true ).order(updated_at: :desc) }
  accepts_nested_attributes_for :pictures, allow_destroy: true

  def latest_books(category)
  end
end
