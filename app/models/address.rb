class Address < ApplicationRecord
  validates :first_name, presence: true
  belongs_to :user
  belongs_to :country


  def full_name
    "#{first_name} #{last_name}"
  end
end
