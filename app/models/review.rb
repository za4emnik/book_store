class Review < ApplicationRecord

  belongs_to :book
  belongs_to :user

  TEXT_FORMAT = %r[[a-z]|[0-9]|[!#$%&'*+-\/=?^_`{|}~]]i
  validates :title, :message, :score, :user_id, :book_id, presence: true
  validates :title, :message, format: { with: TEXT_FORMAT }
  validates :title, length: { maximum: 80 }
  validates :message, length: { maximum: 500 }
  validates :score, numericality: { greater_than: 0, maximum: 5 }
end
