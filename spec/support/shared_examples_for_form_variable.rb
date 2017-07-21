RSpec.shared_examples 'should have @form' do

  it 'should have @form variable' do
    expect(subject.instance_variable_get(:@form)).kind_of? self.class
  end

end
