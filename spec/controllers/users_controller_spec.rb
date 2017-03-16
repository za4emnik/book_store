require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe 'settings' do
    subject { get :edit }

    it 'response should be 200' do
      expect(subject).to redirect_to(new_user_session_path)
      #expect(subject.status).to eq(200)
    end
  end
end
