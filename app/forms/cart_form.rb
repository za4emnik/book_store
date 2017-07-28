class CartForm

  include ActiveModel::Model
  include Virtus.model

  attribute :order, Order, default: Cart.new

  attribute :number, String
  attribute :name, String
  attribute :date, String
  attribute :cvv, Integer


  validates :number, :name, :date, :cvv, :order, presence: true
  validates :name, length: { maximum: 50 }
  validates :number, length: { maximum: 21 }
  validates :cvv, length: { minimum: 3, maximum: 4 }


  def save
    if valid?
      persist!
      true
    else
      false
    end
  end

  private


  def persist!
    cart = Cart.where(order_id: order).first_or_initialize
    cart.update_attributes!(self.attributes)
  end
end
