require 'rails_helper'

RSpec.describe "Tweet Replyies", type: :request do
  describe "POST create" do
    it "Creates a new tweet" do
      user = create(:user)
      parent_tweet = create(:tweet)
      sign_in user
      expect do
        post tweet_replies_path(parent_tweet), params: {
          tweet: {
            body: "New tweet body"
          }
        }
      end.to change { Tweet.count }.by(1)
      expect(response).to redirect_to(tweet_path(parent_tweet))
    end
  end
end