require 'rails_helper'

describe ReviewDecorator, type: :decorator do
  let(:user) { FactoryGirl.create(:user) }
  let(:review) { FactoryGirl.create(:review, user: user).decorate }

  describe '#avatar_url' do
    it 'should return avatar url if avatar exist' do
      some_ulr = '/some/url'
      allow(user).to receive_message_chain(:avatar, :url).and_return(some_ulr)
      expect(review.avatar_url).to eq(some_ulr)
    end

    it 'should return default avatar if avatar not exist' do
      default_avatar_url = '/darthavatar.jpg'
      expect(review.avatar_url).to eq(default_avatar_url)
    end
  end
end
