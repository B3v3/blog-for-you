require 'rails_helper'

RSpec.describe PasswordResetsController, type: :controller do
  let(:user) {create(:user)}
  describe 'POST create' do
    it "sends email to user" do
      expect { post :create, params: { password_reset: {email: user.email}}
      }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end
    it "renders new if email dont exist" do
      post :create, params: { password_reset: {email: 'ran@om.mail'}}
      expect(response).to render_template('new')
    end
  end
end
