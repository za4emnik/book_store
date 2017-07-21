require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do

  describe '#index' do
    subject { get :index }

    it 'response should be 200' do
      expect(subject.status).to eq(200)
    end

    variables = ['books_count', 'categories']
    variables.each do |variable|
      it "should have ##{variable} variable" do
        expect(subject.instance_variable_get(:@variable)).kind_of? subject.class
      end
    end
  end

  describe '#show' do
    subject { get :show, params: { id: FactoryGirl.create(:category).id } }

    it 'response should be 200' do
      expect(subject.status).to eq(200)
    end

    variables = ['books_count', 'categories']
    variables.each do |variable|
      it "should have ##{variable} variable" do
        expect(subject.instance_variable_get(:@variable)).kind_of? subject.class
      end
    end
  end

end
