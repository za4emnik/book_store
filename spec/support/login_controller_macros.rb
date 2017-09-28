module LoginControllerMacros
  def login_admin
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:admin]
      admin = FactoryGirl.create(:admin)
      sign_in admin, scope: :admin
    end
  end

  def login_user
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      user = FactoryGirl.create(:user)
      sign_in user, scope: :user
      user
    end
  end
end
