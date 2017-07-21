require 'rails_helper'

RSpec.describe Author, type: :model do

  context 'associations' do
    it { should have_and_belong_to_many(:books) }
  end

  context 'should be presence' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end

  context '#full_name' do
    it 'should return frist_name and last_name' do
      expect(subject.full_name).to eq("#{subject.first_name} #{subject.last_name}")
    end
  end

end
