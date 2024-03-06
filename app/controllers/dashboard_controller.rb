class DashboardController < ApplicationController
  before_action :authenticate_user!
  def index
    @tweets = Tweet.includes(:liked_users, :bookmarked_users, :user).order(created_at: :desc).select do |tweet|
      tweet if tweet.parent_tweet_id.nil?
    end.map do |tweet|
       TweetPresenter.new(tweet, current_user)
    end
  end
end
