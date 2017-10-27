require 'rails_helper'

describe UsersHelper do
  describe '#active_tab' do
    it 'should return \'#privacy\' tab if email form was sent' do
      controller.params[:email_form] = {}
      expect(helper.active_tab).to eq('#privacy')
    end

    it 'should return \'#privacy\' tab if password form was sent' do
      controller.params[:password_form] = {}
      expect(helper.active_tab).to eq('#privacy')
    end

    it 'should return nil if another form was sent' do
      controller.params[:addresses] = {}
      expect(helper.active_tab).to be_nil
    end
  end
end
