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
end
