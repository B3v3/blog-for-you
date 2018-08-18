require 'rails_helper'

RSpec.describe Follow, type: :model do
  let(:follow) {build(:follow)}

  before(:each) do
    @user  = create(:user)
    @user2 = create(:user2)
  end

  describe 'validations' do
    it "should accept a valid follow" do
      expect(follow.valid?).to be_truthy
    end
    describe 'id validations' do
      it "require a follower id" do
        follow.follower_id = ''
        expect(follow.valid?).to be_falsey
      end
      it "require a followed id" do
        follow.followed_id = ''
        expect(follow.valid?).to be_falsey
      end
    end
  end
end
