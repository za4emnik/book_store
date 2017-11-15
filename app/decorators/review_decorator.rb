class ReviewDecorator < ApplicationDecorator
  def avatar_url
    if model.user.avatar.url(:thumb).blank?
      '/darthavatar.jpg'
    else
      model.user&.avatar&.url(:thumb)
    end
  end
end
