require 'rails_helper'

RSpec.describe Author, type: :model do
  subject(:author) { FactoryGirl.create :author }

  context 'should be presence' do
    it { should validate_presence_of(:first_name) }

    it { should validate_presence_of(:last_name) }
  end

  context 'should have associations' do
    it { should have_and_belong_to_many (:books) }
  end

  it '#full_name should return full name' do
    expect(subject.full_name).to eq("#{subject.first_name} #{subject.last_name}")
  end
end
