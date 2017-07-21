class StepUpdateService

  def initialize(step, order, params, session)
    @step, @order, @user, @params, @session = step, order, order.user, params, session
  end

  def update
    public_send(@step.to_s) if respond_to? @step.to_s
  end

  def address
    form = AddressForm.new(current_user: @user)
    form.billing_address = address_params(:billing_form)
    form.shipping_address = address_params(:shipping_form)
    form.save
    form
  end

  def delivery
    form = DeliveryForm.new(current_order: @order, delivery_id: @params[:order][:delivery])
    form.save
    form
  end

  def payment
    form = CartForm.new(cart_params)
    form.order = @order
    form.save
    form
  end

  def confirm
    @order.waiting_processing!
    @session[:steps_taken?] = false
    @order
  end

  def complete
  end

  private


  def address_params(type)
    @params.require(:address_form).require(type).permit(:first_name, :last_name, :address, :city, :zip, :country_id, :phone, :country_id, :use_billing_address)
  end

  def cart_params
    @params.require(:cart_form).permit(:number, :name, :date, :cvv)
  end
end
