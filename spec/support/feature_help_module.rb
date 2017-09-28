module FeatureHelpModule
  def functionality_steps(content, expected_path = nil)
    expect(page).to have_link(content, match: :first)
    if expected_path
      click_link(content, match: :first)
      expect(current_path).to eql(expected_path)
    end
  end

  def add_book_to_cart
    book = FactoryGirl.create(:book)
    FactoryGirl.create(:picture, book: book)
    visit book_path(book)
    click_button I18n.t(:add_to_cart)
  end

  def go_to_step(step)
    steps = %i[address delivery payment confirm complete]
    visit checkout_path(:address)
    steps[0...steps.index(step)].each do |current_step|
      expect(current_path).to eq(checkout_path(current_step))
      send(current_step)
    end
    expect(current_path).to eq(checkout_path(step))
  end

  private

  def address
    country = FactoryGirl.create(:country)
    address = FactoryGirl.attributes_for(:order_shipping_address)
    visit checkout_path(:address)
    within '#new_address_form' do
      fill_in 'address_form[billing_form][first_name]', with: address[:first_name]
      fill_in 'address_form[billing_form][last_name]', with: address[:last_name]
      fill_in 'address_form[billing_form][address]', with: address[:address]
      fill_in 'address_form[billing_form][city]', with: address[:city]
      fill_in 'address_form[billing_form][zip]', with: address[:zip]
      fill_in 'address_form[billing_form][phone]', with: address[:phone]
      select country.name, from: 'address_form[billing_form][country_id]'

      fill_in 'address_form[shipping_form][first_name]', with: address[:first_name]
      fill_in 'address_form[shipping_form][last_name]', with: address[:last_name]
      fill_in 'address_form[shipping_form][address]', with: address[:address]
      fill_in 'address_form[shipping_form][city]', with: address[:city]
      fill_in 'address_form[shipping_form][zip]', with: address[:zip]
      fill_in 'address_form[shipping_form][phone]', with: address[:phone]
      select country.name, from: 'address_form[shipping_form][country_id]'
      click_button(I18n.t(:save_and_continue), match: :first)
    end
  end

  def delivery
    order = Order.first
    order.delivery = FactoryGirl.create(:delivery)
    order.save
    visit checkout_path(:payment)
  end

  def payment
    cart = FactoryGirl.attributes_for(:cart)
    visit checkout_path(:payment)
    within '#new_cart_form' do
      fill_in 'cart_form[number]', with: cart[:number]
      fill_in 'cart_form[name]', with: cart[:name]
      fill_in 'cart_form[date]', with: cart[:date]
      fill_in 'cart_form[cvv]', with: cart[:cvv]
      click_button(I18n.t(:save_and_continue), match: :first)
    end
  end

  def confirm
    click_button(I18n.t(:place_order), match: :first)
  end
end
