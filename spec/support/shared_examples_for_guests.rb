RSpec.shared_examples 'when guest' do
  it 'shoul redirect to login page' do
    expect(subject).to redirect_to(new_user_session_path)
  end
end
