class StepShowService

  def initialize(step, order, session)
    @step, @order, @user, @session = step, order, order.user.decorate, session
  end

  def form
    public_send(@step.to_s) if respond_to? @step.to_s
  end

  def address
    form = AddressForm.new(current_user: @user)
    form.shipping_address = @user.shipping_address.attributes
    form.billing_address = @user.billing_address.attributes
    form
  end

  def delivery
    Delivery.all
  end

  def payment
    @order.cart ||= Cart.new
    form = CartForm.new(@order.cart.attributes)
    form.order = @order
    form
  end

  def confirm
    @session[:steps_taken?] = true
    @user
  end

  def complete
    order = @user.orders.where.not(aasm_state: 'pending').order(:created_at).last
    order.decorate if order.present?
  end
end
