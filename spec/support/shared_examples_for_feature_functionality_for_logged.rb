RSpec.shared_examples 'functionality for logged user' do |params|

  if params && params[:login_before] && params[:visit_path]
    before do
      signin_user
      visit params[:visit_path]
    end
  end

  it 'shoud have shop name link' do
    functionality_steps(I18n.t(:shop_name), root_path)
  end

  it 'should have home link' do
    functionality_steps(I18n.t(:home), root_path)
  end

  it 'should have shop link' do
    functionality_steps(I18n.t(:shop), categories_path)
  end

  it 'should have my account link' do
    functionality_steps(I18n.t(:my_account))
  end

  it 'shold have orders link' do
    functionality_steps(I18n.t(:orders), orders_path)
  end

  it 'should have settings link' do
    functionality_steps(I18n.t(:settings), settings_path)
  end

  it 'should have log out link' do
    functionality_steps(I18n.t(:log_out), root_path)
  end
end
