class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  #skip_before_filter

  def facebook
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user.persisted?
      sign_in_and_redirect @user
    else
      session['devise.facebook_data'] = request.env['omniauth.auth']
      redirect_to new_user_session_path
    end
  end

  def failure
    redirect_to root_path
  end

end
