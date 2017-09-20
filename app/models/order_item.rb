class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :book

  default_scope -> { preload(:book) }
end
