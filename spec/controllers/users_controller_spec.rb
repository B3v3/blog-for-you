require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:first_user) { create(:user)}
  describe 'GET show' do
    it "shows a certain user" do
      get :show, params: { id: first_user.id }
      expect(assigns :user).to eq(first_user)
    end
  end

  describe 'GET new' do
    it "assigns a blank user to a view" do
      get :new
      expect(assigns :user).to be_a_new(User)
    end
  end

  describe 'Get edit' do
    it "assigns a certain user to a view" do
      get :edit, params: { id: first_user.id }
      expect(assigns :user).to eq(first_user)
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
  end

  describe 'PATCH update' do
    context "Valid params" do
      it "redirects to user page" do
        patch :update, params: {id: first_user.id, user: {nickname: 'updated'}}
        expect(response).to redirect_to(first_user)
      end
      it "update a user in database" do
        patch :update, params: {id: first_user.id, user: {nickname: 'updated'}}
        first_user.reload
        expect(first_user.nickname).to eql('updated')
      end
    end
    context "Invalid params" do
      it "renders a edit page" do
        patch :update, params: {id: first_user.id, user: {nickname: ''}}
        expect(response).to render_template(:edit)
      end
      it "updates nothing in database" do
        patch :update, params: {id: first_user.id, user: {nickname: 'rg#$i./t'}}
        expect(first_user.nickname).to eql('D3v3')
      end
    end
  end

  describe 'DELETE destroy' do
    it "delete a certain user" do
      first_user
      expect{delete :destroy, params: { id: first_user.id}
      }.to change(User, :count).by(-1)
    end
  end
end
