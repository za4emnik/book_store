class Book < ApplicationRecord
  validates :title, :price, :description, :category_id, presence: true

  has_and_belongs_to_many :authors
  has_many :pictures
  belongs_to :category
  accepts_nested_attributes_for :pictures, allow_destroy: true
end
