require 'rails_helper'

RSpec.describe PasswordForm, type: :model do
  let(:user) { FactoryGirl.create(:user) }
  let(:password_form) { PasswordForm.new }

  before do
    password_form.current_user = user
  end

  describe '#old_password_validation' do
    it 'should add old password error if password not valid' do
      password_form.old_password = 'some_invalid_password'
      password_form.old_password_validation
      expect(password_form.errors[:old_password]).not_to be_empty
    end
  end

  describe '#new_password_validation' do
    it 'should add password error if password not valid' do
      password_form.password = 'some.invalid.password '
      password_form.new_password_validation
      expect(password_form.errors[:password]).not_to be_empty
    end

    it 'should add confirmation password error if password not valid' do
      password_form.password = 'some.invalid.password '
      password_form.password_confirmation = 'some.invalid.password '
      password_form.new_password_validation
      expect(password_form.errors[:password_confirmation]).not_to be_empty
    end

    it 'should add confirmation password error if password not match' do
      password_form.old_password = 'pAssWord123'
      password_form.password = 'Validpassword1'
      password_form.password_confirmation = 'Validpassword2'
      password_form.new_password_validation
      expect(password_form.errors[:password_confirmation]).not_to be_empty
    end
  end
end
