require 'rails_helper'

RSpec.describe Comment, type: :model do
  before(:each) do
    create(:user)
    create(:post)
  end

  let(:first_comment) {build(:comment)}

describe 'Validations' do
  it "should accept a valid comment" do
    expect(first_comment.valid?).to be_truthy
  end

  describe 'content' do
    it "should have content" do
      first_comment.content = ''
      expect(first_comment.valid?).to be_falsey
    end

    it "content shoud be longer than 2 characters" do
      first_comment.content = 'a'
      expect(first_comment.valid?).to be_falsey
    end

    it "content should be shorter than 501 characters" do
      first_comment.content = 'a'*501
      expect(first_comment.valid?).to be_falsey
    end
  end

  it "should have user id" do
    first_comment.user_id = ''
    expect(first_comment.valid?).to be_falsey
  end

  it "should have post id" do
    first_comment.user_id = ''
    expect(first_comment.valid?).to be_falsey
  end
end
end
