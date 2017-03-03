class Book < ApplicationRecord
  has_and_belongs_to_many :authors
  has_many :pictures
  accepts_nested_attributes_for :pictures, allow_destroy: true
end
