RSpec.shared_examples 'redirect to root page' do

  it 'shoul redirect to root page' do
    expect(subject).to redirect_to(root_path)
  end

end
