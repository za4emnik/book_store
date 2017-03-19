class Address < ApplicationRecord

  belongs_to :user
  belongs_to :country


  def full_name
    "#{first_name} #{last_name}"
  end
end
