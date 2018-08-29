require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    let(:user) { build(:user)}

    it 'accepts a valid user' do
      expect(user.valid?).to be_truthy
    end

    describe 'nickname' do
      it "should be present" do
        user.nickname = ""
        expect(user.valid?).to be_falsey
      end
      it "should be longer than 2 characters" do
        user.nickname = "a"*2
        expect(user.valid?).to be_falsey
      end
      it "should be shorter thank 26 characters" do
        user.nickname = "a"*26
        expect(user.valid?).to be_falsey
      end
      it "should be unique" do
        user.save
        new_user = build(:user, email: 'random@email.com', password:"testpass")
        expect(new_user.valid?).to be_falsey
      end
      it "should be made only of letters and numbers" do
        user.nickname = "#%$%}{}:/"
        expect(user.valid?).to be_falsey
      end
    end

    describe 'email' do
      it "should be present" do
        user.email = ""
        expect(user.valid?).to be_falsey
      end
      it "should be shorter thank 200 characters" do
        user.email = "#{'a'*200}@rew.raw"
        expect(user.valid?).to be_falsey
      end
      it "should be unique" do
        user.save
        new_user = build(:user, nickname: 'randomme', password:"testpass")
        expect(new_user.valid?).to be_falsey
      end
      it "should be a valid email" do
        user.email = 'somebodyoncetoldme'
        expect(user.valid?).to be_falsey
      end
    end

    describe 'password' do
      it "should be present" do
        new_user = build(:user, password: "")
        expect(new_user.valid?).to be_falsey
      end
      it "should be longer than 5 characters" do
        user.password = "a"*5
        expect(user.valid?).to be_falsey
      end
      it "requires a password confirmation" do
        user.password_confirmation = ""
        expect(user.valid?).to be_falsey
      end
      it "requires a password confirmation same as password" do
        user.password_confirmation = '1232afsasfaf'
        expect(user.valid?).to be_falsey
      end
    end
  end

    describe 'followings' do
      before(:each) do
        @user = create(:user)
        @user2 = create(:user2)
      end

      it "should not have any follows at start" do
        expect(@user.following?(@user2)).to be_falsey
      end
      it "should follow a user" do
        @user.follow(@user2)
        expect(@user.following?(@user2)).to be_truthy
        expect(@user2.followers.include?(@user)).to be_truthy
      end
      it "should unfollow a user" do
        @user.follow(@user2)
        @user.unfollow(@user2)
        expect(@user.following?(@user2)).to be_falsey
      end

      describe 'user feed' do
        it "should show all posts of followed users" do
          create(:post)
          create(:first_post)
          @user2.follow(@user)
          expect(@user2.feed).to eq(@user.posts)
        end
        it "should dont show anything at start" do
          expect(@user.feed).to eq([])
        end
      end
    end

    describe 'Destroying' do
      before(:each) do
        @user = create(:user)
      end

        it "should delete user posts" do
          create(:post)
          expect{ @user.destroy}.to change(Post, :count).by(-1)
        end
        it "should delete user follows" do
          create(:user2)
          create(:follow)
          expect{ @user.destroy}.to change(Follow, :count).by(-1)
        end

        it "should delete user comments" do
          create(:post)
          create(:comment)
          expect{ @user.destroy}.to change(Comment, :count).by(-1)
        end

        it "should delete user likes" do
          create(:post)
          create(:like)
          expect{ @user.destroy}.to change(Like, :count).by(-1)
        end
    end
  end
