require "rails_helper"

RSpec.describe TweetPresenter, type: :presenter do
  describe "#created_at" do
    context "when tweet was created more than 24 hours ago" do
      before do
        travel_to Time.local(2024, 2, 27)
      end

      after do
        travel_back
      end

      it "displays the date when Tweet was posted" do
        tweet = create(:tweet)
        tweet.update! created_at: 5.days.ago
        expect(TweetPresenter.new(tweet).created_at).to eq("Feb 22")
      end
    end

    context "when tweet was created less than 24 hours ago" do
      it "displays how many hours have past" do
        tweet = create(:tweet)
        tweet.update! created_at: 5.hours.ago
        expect(TweetPresenter.new(tweet).created_at).to eq("about 5 hours")
      end

      it "displays how many minutes have past" do
        tweet = create(:tweet)
        tweet.update! created_at: 10.minutes.ago
        expect(TweetPresenter.new(tweet).created_at).to eq("10 minutes")
      end
    end
  end
end
