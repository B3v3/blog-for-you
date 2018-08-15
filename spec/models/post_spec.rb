require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { build(:post) }

  describe 'validations' do
    it 'accepts valid post' do
      expect(post.valid?).to be_truthy
    end

    describe 'title' do
      it "should exist" do
        post.title = ''
        expect(post.valid?).to be_falsey
      end
      it "should be shorter than 121 characters" do
        post.title = 'a'*121
        expect(post.valid?).to be_falsey
      end
      it "should be longer than 5 characters" do
        post.title = 'a'*5
        expect(post.valid?).to be_falsey
      end
      it "should be unique" do
        post.save

        new_post = build(:post)
        expect(new_post.valid?).to be_falsey
      end
    end

    describe 'content' do
      it "should exist" do
        post.content = ''
        expect(post.valid?).to be_falsey
      end
      it "should be longer than 10 characters" do
        post.content = 'a'*10
        expect(post.valid?).to be_falsey
      end
      it "should not be longer than 10000 characters" do
        post.content = 'a'*10001
        expect(post.valid?).to be_falsey
      end
    end
  end
end
