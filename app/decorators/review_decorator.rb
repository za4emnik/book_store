class ReviewDecorator < ApplicationDecorator
  def avatar_url
    if model.user.avatar.url(:thumb).blank?
      '/uploads/img/darthavatar.jpg'
    else
      model.user&.avatar&.url(:thumb)
    end
  end
end
