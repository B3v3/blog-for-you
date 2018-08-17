require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:first_user) { create(:user)}
  let(:second_user) { create(:user2)}
  describe 'GET show' do
    it "shows a certain user" do
      log_in_as(first_user)
      get :show, params: { id: first_user.id }
      expect(assigns :user).to eq(first_user)
    end
    it "redirects to root path if user is not logged in" do
      get :show, params: { id: first_user.id }
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'GET new' do
    it "assigns a blank user to a view" do
      get :new
      expect(assigns :user).to be_a_new(User)
    end
    it "redirect to a user page if you are logged in" do
      log_in_as(first_user)
      get :new
      expect(response).to redirect_to(first_user)
    end
  end

  describe 'Get edit' do
    it "assigns a certain user to a view" do
      log_in_as(first_user)
      get :edit, params: { id: first_user.id }
      expect(assigns :user).to eq(first_user)
    end
    it "redirect to root path if you are not logged in" do
      get :edit, params: { id: first_user.id }
      expect(response).to redirect_to(root_path)
    end
    it "redirect to current user page if user is not owner" do
      log_in_as(second_user)
      get :edit, params: { id: first_user.id }
      expect(response).to redirect_to(second_user)
    end
  end

  describe 'POST create' do
    context 'Valid params' do
      it "redirects to user page" do
        post :create, params: {user: attributes_for(:user)}
        expect(response).to redirect_to(user_path(User.last))
      end
      it "creates a new user in database" do
        expect{ post :create, params: {user: attributes_for(:user)}}
        .to change(User, :count).by(1)
      end
    end
    context 'Invalid params' do
      it "renders a register page" do
        post :create, params: {user: attributes_for(:user, nickname: '')}
        expect(response).to render_template(:new)
      end
      it "creates nothing in database" do
        expect{ post :create, params: {user: attributes_for(:user, nickname:'')}}
        .to change(User, :count).by(0)
      end
    end
    it "redirect to user page if you are logged in" do
      log_in_as(first_user)
      post :create, params: {user: attributes_for(:user2)}
      expect(response).to redirect_to(first_user)
    end
  end

  describe 'PATCH update' do
    context "Valid params" do
      it "redirects to user page" do
        log_in_as(first_user)
        patch :update, params: {id: first_user.id, user: {nickname: 'updated'}}
        expect(response).to redirect_to(first_user)
      end
      it "update a user in database" do
        log_in_as(first_user)
        patch :update, params: {id: first_user.id, user: {nickname: 'updated'}}
        first_user.reload
        expect(first_user.nickname).to eql('updated')
      end
    end
    context "Invalid params" do
      it "renders a edit page" do
        log_in_as(first_user)
        patch :update, params: {id: first_user.id, user: {nickname: ''}}
        expect(response).to render_template(:edit)
      end
      it "updates nothing in database" do
        log_in_as(first_user)
        patch :update, params: {id: first_user.id, user: {nickname: 'rg#$i./t'}}
        first_user.reload
        expect(first_user.nickname).to eql('D3v3')
      end
    end
    it "redirect to root path if you are not logged in" do
      patch :update, params: {id: first_user.id, user: {nickname: 'updated'}}
      expect(response).to redirect_to(root_path)
    end
    it "redirect to current user page if user is not owner" do
      log_in_as(second_user)
      patch :update, params: {id: first_user.id, user: {nickname: 'updated'}}
      expect(response).to redirect_to(second_user)
    end
    it "dont change anything if current user is not owner" do
      log_in_as(second_user)
      patch :update, params: {id: first_user.id, user: {nickname: 'updated'}}
      first_user.reload
      expect(first_user.nickname).to eql('D3v3')
    end
  end

  describe 'DELETE destroy' do
    it "delete a certain user" do
      log_in_as(first_user)
      expect{delete :destroy, params: { id: first_user.id}
      }.to change(User, :count).by(-1)
    end
    it "redirects to root path after delete" do
      log_in_as(first_user)
      delete :destroy, params: { id: first_user.id}
      expect(response).to redirect_to(root_path)
    end
    it "redirects to root path if you are not logged in" do
      delete :destroy, params: { id: first_user.id}
      expect(response).to redirect_to(root_path)
    end
    it "dont delete anything if you are not logged in" do
      first_user #just to create record in DB
      expect{delete :destroy, params: { id: first_user.id}
      }.to change(User, :count).by(0)
    end
    it "redirects to current user page if user is not owner" do
      log_in_as(second_user)
      delete :destroy, params: { id: first_user.id}
      expect(response).to redirect_to(second_user)
    end
    it "dont delete anything if current user is not owner" do
      log_in_as(second_user)
      first_user #just to create record in DB
      expect{delete :destroy, params: { id: first_user.id}
      }.to change(User, :count).by(0)
    end
  end
end
