class Coupon < ApplicationRecord
  belongs_to :order
  validates :code, :value, presence: true
end
