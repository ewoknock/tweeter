require "rails_helper"

RSpec.describe "Follows", type: :request do
  let(:user_1) { create(:user) }
  let(:user_2) { create(:user) }

  before { sign_in user_1 }

  describe "POST create" do 
    it "Creates a new follow" do
      expect do
        post user_follows_path(user_1), params: {
          following_user_id: user_2.id
        }
      end.to change { Follow.count }.by(1)
      expect(response).to redirect_to user_path(user_2)
    end
  end

  describe "DELETE destroy" do
    it "Deletes an existing follow" do
      follow = create(:follow, user: user_1, following_user: user_2)
      expect do
        delete user_follow_path(user_1, follow)
      end.to change { Follow.count }.by(-1)
      expect(response).to redirect_to user_path(user_2)
    end
  end
end