class ProfileController < ApplicationController
  before_action :authenticate_user!

  def show
    @profile_nav_class = "profile-nav-action"
    get_tweets(params[:source])
  end

  private
  
  def get_tweets(source)
    case source
    when "replies"
      @tweets = user_posts
      @msg = "#{@tweets.size} posts"
      @replies_active = "active"
    when "likes"
      @tweets = user_likes
      @msg = "#{@tweets.size} likes"
      @likes_active = "active"
    else
      @tweets = user_posts
      @msg = "#{@tweets.size} posts"
      @posts_active = "active"
    end
  end

  def user_posts
    current_user.tweets.order(created_at: :desc).map do |tweet|
      TweetPresenter.new(tweet, current_user)
    end 
  end

  def user_likes
    current_user.liked_tweets.order(created_at: :desc).map do |tweet|
      TweetPresenter.new(tweet, current_user)
    end
  end
end