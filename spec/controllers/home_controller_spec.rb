require 'rails_helper'

RSpec.describe HomeController, type: :controller do

  describe 'index' do
    subject { get :index }

    it 'response should be 200' do
      expect(subject.status).to eq(200)
    end

    variables = ['latest_books', 'bestsellers']
    variables.each do |variable|
      it "should have ##{variable} variable" do
        expect(subject.instance_variable_get(:@variable)).kind_of? subject.class
      end
    end


  end

end
