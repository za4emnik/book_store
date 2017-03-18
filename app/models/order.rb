class Order < ApplicationRecord
  has_many   :order_items
  has_one    :coupon
  belongs_to :user
  belongs_to :order

  def subtotal
    @subtotal = self.order_items.collect{ |item| item.quantity * item.book.price }.sum
  end

  def total
    @subtotal - self.coupon.value
  end
end
