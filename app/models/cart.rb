class Cart < ApplicationRecord
  belongs_to :order

  validates :number, :name, :date, :cvv, :order_id, presence: true
  validates :number, numericality: { only_integer: true }
  validates :name, length: { maximum: 50 }
  #validates :date, format: { with: /[0-3]{1}[0-9]{1}\/[0-1]{1}[0-2]{1}/ }
  validates :cvv, length: { minimum: 3, maximum: 4 }
end
