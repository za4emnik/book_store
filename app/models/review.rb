class Review < ApplicationRecord
  include AASM

  belongs_to :book
  belongs_to :user

  TEXT_FORMAT = %r[[a-z]|[0-9]|[!#$%&'*+-\/=?^_`{|}~]]i
  validates :title, :message, :score, :user_id, :book_id, presence: true
  validates :title, length: { maximum: 80 }
  validates :title, :message, format: { with: TEXT_FORMAT }
  validates :message, length: { maximum: 500 }
  validates :score, numericality: { greater_than: 0, less_than: 6 }

  aasm do
    state :unprocessed, initial: true
    state :approved
    state :rejected

    event :approve do
      transitions from: [:unprocessed, :rejected], to: :approved
    end

    event :reject do
      transitions from: [:unprocessed, :approved], to: :rejected
    end
  end
end
