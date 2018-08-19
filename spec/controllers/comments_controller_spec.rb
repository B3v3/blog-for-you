require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:comment)       {build(:comment)}
  let(:comment2)      {create(:comment2)}
  let(:user)          {create(:user)}
  let(:user2)         {create(:user2)}
  let(:f_post)        {create(:post)}

  describe 'POST create' do
    it "creates a comment for specific post" do
      log_in_as(user)
      expect{ post :create, params: {id: f_post.id, comment:
        { content: comment.content}}}.to change(f_post.comments, :count).by(1)
    end

    it "assigns a current user as a comment creator" do
      log_in_as(user)
      post :create, params: {id: f_post.id, comment:{ content: comment.content}}
      expect(Comment.last.user).to eql(user)
    end

    it "renders a post when comment have a valid params" do
      log_in_as(user)
      post :create, params: {id: f_post.id, comment:{ content: ''}}
      expect(response).to redirect_to(f_post)
    end
  end

  describe 'PATCH update' do
    it "changes a comment content to specific message" do
      log_in_as(user)
      f_post
      comment.save
      patch :update, params: { id: 1}
      comment.reload
      expect(comment.content).to eql("Deleted by D3v3")
    end
  end
end
