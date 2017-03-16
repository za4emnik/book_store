class User < ApplicationRecord
  has_one :shipping_address, dependent: :destroy
  has_one :billing_address, dependent: :destroy
  has_many :reviews

  devise :database_authenticatable, :recoverable,
         :rememberable, :trackable, :validatable,
         :omniauthable, :registerable

  mount_uploader :avatar, AvatarUploader

  def self.new_with_session(params, session)
    super.tap do |user|
     if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
       user.email = data["email"] if user.email.blank?
     end
    end
  end


  protected


  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end

end
