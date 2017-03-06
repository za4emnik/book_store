require 'rails_helper'

RSpec.describe BooksController, type: :controller do

  describe 'show' do
    subject { get :show, params: { id: FactoryGirl.create(:book).id } }

    it 'response should be 200' do
      expect(subject.status).to eq(200)
    end

    variables = ['books']
    variables.each do |variable|
      it "should have ##{variable} variable" do
        expect(subject.instance_variable_get(:@variable)).kind_of? subject.class
      end
    end
  end

end
