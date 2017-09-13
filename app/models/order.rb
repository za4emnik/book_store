class Order < ApplicationRecord
  include AASM

  after_create :generate_order_number

  has_one    :coupon
  has_one    :cart
  has_one    :shipping_address, as: :addressable, dependent: :destroy
  has_one    :billing_address, as: :addressable, dependent: :destroy
  has_many   :order_items
  belongs_to :user
  belongs_to :delivery

  aasm do
    state :pending, initial: true
    state :waiting_for_processing
    state :in_progress
    state :in_delivery
    state :delivered
    state :cancelled

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

    event :cancelled do
      transitions from: Order.aasm.states.map(&:name) - [:cancelled], to: :cancelled
    end
  end

  def self.with_filter(filter)
    case filter
    when 'waiting_for_processing'
      self.where(aasm_state: 'waiting_for_processing')
    when 'in_progress'
      self.where(aasm_state: 'in_progress')
    when 'in_delivery'
      self.where(aasm_state: 'in_delivery')
    when 'delivered'
      self.where(aasm_state: 'delivered')
    else
      self.all
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


  private

  def generate_order_number
    number = if self.id.to_s.length < 8
      'R'+('0' * (8 - self.id.to_s.length))
    end
    self.update!(number: number + self.id.to_s)
  end
end
