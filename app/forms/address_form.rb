class AddressForm < Rectify::Form

  attribute :first_name, String
  attribute :last_name, String
  attribute :address, String
  attribute :city, String
  attribute :zip, String
  attribute :country, String
  attribute :phone, String


  # Validations
  validates :first_name, presence: true

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
    user = User.create!(email: email)
    @expense = user.expenses.create!(amount: amount, paid: paid)
  end
end
