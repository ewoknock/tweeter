class DashboardController < ApplicationController
  before_action :authenticate_user!
  def index
    @tweets = Tweet.includes(:liked_users, :user).order(created_at: :desc).map { |tweet| TweetPresenter.new(tweet, current_user) }
  end
end
