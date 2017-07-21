class AddressBuildForm

  include ActiveModel::Model
  include Virtus.model

  attribute :first_name, String
  attribute :last_name, String
  attribute :address, String
  attribute :city, String
  attribute :zip, Integer
  attribute :country_id, Integer
  attribute :phone, String

  validates :first_name, :last_name, :address, :city, :zip, :phone, presence: true
  validates :first_name, :last_name, :city, format: { with:  /[A-Z][a-z]/ }
  validates :first_name, :last_name, :city, length: { maximum: 50 }
  validates :zip, numericality: { only_integer: true }
  validates :phone, numericality: { greater_than: 0, maximum: 15 }

  def save
    if valid?
      true
    else
      false
    end
  end

end
