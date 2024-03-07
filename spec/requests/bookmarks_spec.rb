require 'rails_helper'

RSpec.describe "Bookmark", type: :request do
  describe "GET /bookmark" do
    context "when not signed in" do
      it "responds with redirect" do
        get bookmarks_path
        expect(response).to have_http_status(:redirect)
      end
    end
    
    context "when logged in" do
      it "is successful" do
        user = create(:user)
        sign_in user
        get bookmarks_path
        expect(response).to have_http_status(:success)
      end
    end
  end
end