require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:first_post) { create(:post)}
  let(:second_user) { create(:user2)}
  before(:each) do
    @first_user = create(:user)
  end
  context "GET show" do
    it "shows a certain post" do
      log_in_as(@first_user)
      get :show, params: {id: first_post.id}
      expect(assigns (:post)). to eq(first_post)
    end
    it "redirect to root path if not logged in" do
      get :show, params: {id: first_post.id}
      expect(response).to redirect_to(root_path)
    end
  end

  context "GET new" do
    it "assigns a blank post to view" do
      log_in_as(@first_user)
      get :new
      expect(assigns(:post)).to be_a_new(Post)
    end
    it "redirect to root path if not logged in" do
      get :new
      expect(response).to redirect_to(root_path)
    end
  end

  context "GET edit" do
    it "assigns a certain post to view" do
      log_in_as(@first_user)
      get :edit, params: {id: first_post.id}
      expect(assigns (:post)).to eq(first_post)
    end
    it "redirect to root path if not logged in" do
      get :edit, params: {id: first_post.id}
      expect(response).to redirect_to(root_path)
    end
    it "redirect to current user page if user is not owner" do
      log_in_as(second_user)
      get :edit, params: {id: first_post.id}
      expect(response).to redirect_to(second_user)
    end
  end

  context "POST create" do
    context "Valid Params" do
      it "redirects to show page" do
        log_in_as(@first_user)
        post :create, params: {post: attributes_for(:first_post)}
        expect(response).to redirect_to(post_path(Post.last))
      end
      it "creates a new post in database" do
        log_in_as(@first_user)
        expect{ post :create, params: {post: attributes_for(:first_post)}
      }.to change(Post, :count).by(1)
      end
    end
    context "Invalid Params" do
      it 'render new template' do
        log_in_as(@first_user)
        post :create, params: {post: attributes_for(:post, title: '')}
        expect(response).to render_template(:new)
      end
      it "doesnt create anything in database" do
        log_in_as(@first_user)
        expect{ post :create, params: {post: attributes_for(:post, title: "")}
      }.to change(Post, :count).by(0)
      end
    end
    it "redirect to root path if not logged in" do
      post :create, params: {post: attributes_for(:first_post)}
      expect(response).to redirect_to(root_path)
    end
  end

  context "PATCH update" do
    context "Valid Params" do
      it "redirects to show page" do
        log_in_as(@first_user)
        patch :update, params: {id: first_post.id, post: {title: 'updated'}}
        expect(response).to redirect_to(post_path(first_post))
      end
      it "changes a post in database" do
        log_in_as(@first_user)
        patch :update, params: {id: first_post.id, post: {title: 'updated'}}
        first_post.reload
        expect(first_post.title).to eq("updated")
      end
    end
    context "Invalid Params" do
      it 'render edit template' do
        log_in_as(@first_user)
        patch :update, params: {id: first_post.id, post: {title: ''}}
        expect(response).to render_template(:edit)
      end
      it "doesnt create anything in database" do
        log_in_as(@first_user)
        patch :update, params: {id: first_post.id, post: {title: ''}}
        first_post.reload
        expect(first_post.title).to eq("Top 10 ruby methods")
      end
    end
    it "redirect to root path if not logged in" do
      patch :update, params: {id: first_post.id, post: {title: 'updated'}}
      expect(response).to redirect_to(root_path)
    end
    it "redirect to current user page if user is not owner" do
      log_in_as(second_user)
      patch :update, params: {id: first_post.id, post: {title: 'updated'}}
      expect(response).to redirect_to(second_user)
    end
    it "dont change anything if user is not owner" do
      log_in_as(second_user)
      patch :update, params: {id: first_post.id, post: {title: 'updated'}}
      first_post.reload
      expect(first_post.title).to eq("Top 10 ruby methods")
    end
  end

  context "DELETE destroy" do
    it "deletes a post" do
      log_in_as(@first_user)
      first_post #just to add record in DB
      expect{ delete :destroy, params: {id: first_post.id}
    }.to change(Post, :count).by(-1)
      expect(response).to redirect_to(root_path)
    end
    it "redirect to root path if not logged in" do
      first_post #just to add record in DB
      delete :destroy, params: {id: first_post.id}
      expect(response).to redirect_to(root_path)
    end
    it "dont delete a post if user is not owner" do
      first_post #just to add record in DB
      expect{ delete :destroy, params: {id: first_post.id}
    }.to change(Post, :count).by(0)
    end
    it "redirect to current user page if user is not owner" do
      log_in_as(second_user)
      first_post #just to add record in DB
      delete :destroy, params: {id: first_post.id}
      expect(response).to redirect_to(second_user)
    end
    it "dont delete a post if user is not owner" do
      log_in_as(second_user)
      first_post #just to add record in DB
      expect{ delete :destroy, params: {id: first_post.id}
    }.to change(Post, :count).by(0)
    end
  end
end
