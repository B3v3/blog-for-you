require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:first_like) {build(:like)}
  describe 'validations' do
    before(:each) do
      create(:user)
      create(:user2)
      create(:post)
    end

    it "should accept a valid like" do
      expect(first_like.valid?).to be_truthy
    end
    it "should require post id" do
      first_like.post_id = ''
      expect(first_like.valid?).to be_falsey
    end
    it "should requier user id" do
      first_like.user_id = ''
      expect(first_like.valid?).to be_falsey
    end
    it "should not accept same likes" do
      first_like.save
      same_like = build(:like)
      expect{same_like.save}.to raise_error(ActiveRecord::RecordNotUnique)
    end
  end
end
