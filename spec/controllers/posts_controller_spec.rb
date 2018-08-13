require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:first_post) { create(:post)}
  context "GET show" do
    it "shows a certain poem" do
      get :show, params: {id: first_post.id}
      expect(assigns (:post)). to eq(first_post)
    end
  end

  context "GET new" do
    it "assigns a blank poem to view" do
      get :new
      expect(assigns(:post)).to be_a_new(Post)
    end
  end

  context "GET edit" do
    it "assigns a certain poem to view" do
      get :edit, params: {id: first_post.id}
      expect(assigns (:post)).to eq(first_post)
    end
  end

  context "POST create" do
    context "Valid Params" do
      it "redirects to show page" do
        post :create, params: {post: attributes_for(:first_post)}
        expect(response).to redirect_to(post_path(Post.last))
      end
      it "creates a new post in database" do
        expect{ post :create, params: {post: attributes_for(:first_post)}
      }.to change(Post, :count).by(1)
      end
    end
    context "Invalid Params" do
      it 'render new template' do
        post :create, params: {post: attributes_for(:post, title: '')}
        expect(response).to render_template(:new)
      end
      it "doesnt create anything in database" do
        expect{ post :create, params: {post: attributes_for(:post, title: "")}
      }.to change(Post, :count).by(0)
      end
    end
  end

  context "PUT update" do
    context "Valid Params" do
      it "redirects to show page" do
        patch :update, params: {id: first_post.id, post: {title: 'updated'}}
        expect(response).to redirect_to(post_path(first_post))
      end
      it "changes a poem in database" do
        patch :update, params: {id: first_post.id, post: {title: 'updated'}}
        first_post.reload
        expect(first_post.title).to eq("updated")
      end
    end
    context "Invalid Params" do
      it 'render edit template' do
        patch :update, params: {id: first_post.id, post: {title: ''}}
        expect(response).to render_template(:edit)
      end
      it "doesnt create anything in database" do
        patch :update, params: {id: first_post.id, post: {title: ''}}
        first_post.reload
        expect(first_post.title).to eq("Top 10 ruby methods")
      end
    end
  end

  context "DELETE destroy" do
    it "deletes a poem" do
      first_post #just to add record in DB
      expect{ delete :destroy, params: {id: first_post.id}
    }.to change(Post, :count).by(-1)
      expect(response).to redirect_to(root_path)
    end
  end
end
