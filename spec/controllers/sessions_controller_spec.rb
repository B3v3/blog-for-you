require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let(:first_user) { create(:user)}
  let(:second_user) { create(:user2)}

  describe "GET new" do
    it "should get new" do
      get :new
      expect(response).to have_http_status(:success)
    end
    it "should redirect to user page if logged in" do
      log_in_as(first_user)
      get :new
      expect(response).to redirect_to(first_user)
    end
  end

  describe 'POST create' do
    describe 'not logged user' do
      it "should redirect to user page" do
        post :create, params: { sessions: { email:    first_user.email,
                                            password: first_user.password } }
        expect(response).to redirect_to(first_user)
      end

      it "should log_in user" do
        post :create, params: { sessions: { email:    first_user.email,
                                            password: first_user.password } }
        expect(is_logged_in?).to be_truthy
      end
    end
    describe 'logged user' do
      it "should redirect to logged user page" do
        log_in_as(first_user)
        post :create, params: { sessions: { email:    second_user.email,
                                            password: second_user.password } }
        expect(response).to redirect_to(first_user)
      end
    end
  end

  describe 'DELETE destroy' do
    describe 'logged user' do
      it 'redirect to root page' do
        log_in_as(first_user)
        delete :destroy
        expect(response).to redirect_to(root_path)
      end
      it "log out user" do
        log_in_as(first_user)
        delete :destroy
        expect(is_logged_in?).to be_falsey
      end
    end
  end
end
