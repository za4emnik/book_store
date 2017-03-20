class Address < ApplicationRecord
  validates :first_name, presence: true
  belongs_to :user
  belongs_to :country

  validates :first_name, :last_name, :address, :city, :zip, :phone, presence: true
  validates :first_name, :last_name, :city, format: { with:  /[A-Z][a-z]/ }
  validates :first_name, :last_name, :city, length: { maximum: 50 }
  validates :zip, numericality: { only_integer: true }
  validates :phone, numericality: { greater_than: 0, maximum: 15 }

  def full_name
    "#{first_name} #{last_name}"
  end
end
