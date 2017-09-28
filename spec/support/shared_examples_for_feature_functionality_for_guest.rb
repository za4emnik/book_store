RSpec.shared_examples 'functionality for guest' do |params|
  if params && params[:visit_path]
    before do
      visit params[:visit_path]
    end
  end

  it 'shoud have shop name link' do
    functionality_steps(I18n.t(:shop_name), root_path)
  end

  it 'should have home link' do
    functionality_steps(I18n.t(:home))
  end

  it 'should have shop link' do
    functionality_steps(I18n.t(:shop), categories_path)
  end

  it 'should have login link' do
    functionality_steps(I18n.t(:log_in), login_path)
  end

  it 'shold have signup link' do
    functionality_steps(I18n.t(:sign_up), signup_path)
  end
end
