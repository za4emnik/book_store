class Order < ApplicationRecord
  include AASM

  has_one    :coupon
  has_one    :cart
  has_many   :order_items
  belongs_to :user
  belongs_to :delivery

  aasm do
    state :pending, initial: true
    state :waiting_for_processing
    state :in_progress
    state :in_delivery
    state :delivered

    event :waiting_processing do
      transitions from: :pending, to: :waiting_for_processing
    end

    event :progress do
      transitions from: :waiting_for_processing, to: :in_progress
    end

    event :delivered do
      transitions from: :in_progress, to: :in_delivery
    end

    event :complete do
      transitions from: :in_delivery, to: :delivered
    end
  end

  def update_total!
    total = coupon ? coupon.value : 0
    total -= delivery.price if delivery
    self.total = subtotal - total
    self.save
  end

  def subtotal!
    self.subtotal = order_items.collect{ |item| item.quantity * item.book.price }.sum
    self.save
  end
end
