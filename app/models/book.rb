class Book < ApplicationRecord
  validates :title, :price, :description, :category_id, presence: true

  has_and_belongs_to_many :authors
  has_and_belongs_to_many :materials
  has_many :pictures
  has_many :reviews, -> { where(published: true ).order(updated_at: :desc) }
  belongs_to :category
  accepts_nested_attributes_for :pictures, allow_destroy: true

  def latest_books(category)
  end
end
