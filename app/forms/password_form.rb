class PasswordForm
  include ActiveModel::Model
  include Virtus.model

  attribute :old_password, String
  attribute :password, String
  attribute :password_confirmation, String
  attribute :current_user, User

  validate :old_password_validation
  validate :new_password_validation

  def save
    if valid?
      persist!
      true
    else
      false
    end
  end

  def old_password_validation
    unless current_user.valid_password?(old_password)
      errors.add(:old_password, I18n.t(:password_is_not_correct))
    end
  end

  def new_password_validation
    current_user.attributes = form_params
    if current_user.invalid?
      errors.add(:password, current_user.errors[:password])
      errors.add(:password_confirmation, current_user.errors[:password_confirmation])
    end
  end

  private

  def persist!
    current_user.update(form_params)
  end

  def form_params
    attributes.slice(:password, :password_confirmation)
  end
end
