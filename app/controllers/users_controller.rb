class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    redirect_to profile_path if user == current_user
    
    @tweets = tweet.map do |tweet|
      TweetPresenter.new(tweet, user)
    end
    @posts_active = "active"
    @msg = "#{@tweets.size} posts"
    #get_tweets(params[:source])
    respond_to do |format|
      format.html
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace("profile-tweets", partial: "user_nav", locals: {user: user, tweets: @tweets})
      end
    end
  end

  def likes
    @tweets = user.liked_tweets.order(created_at: :desc).map do |tweet|
      TweetPresenter.new(tweet, user)
    end
    @likes_active = "active"
    @msg = "#{@tweets.size} likes"
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace("profile-tweets", partial: "user_nav", locals: {user: user, tweets: @tweets})
      end
    end
  end

  def replies
    @tweets = user_replies
    @replies_active = "active"
    @msg = "#{@tweets.size} posts"
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace("profile-tweets", partial: "user_nav", locals: {user: user, tweets: @tweets})
      end
    end
  end

  private

  def user_replies
    @tweets = Array.new()
    tweet.each do |reply|
      unless reply.parent_tweet_id.nil?
          @tweets.push(reply.parent_tweet) #unless @tweets.include?(reply.parent_tweet)
          @tweets.push(reply)
      end
    end
    @tweets.map do |tweet|
      TweetPresenter.new(tweet, user)
    end
  end

  def user_likes
    user.liked_tweets.order(created_at: :desc).map do |tweet|
      TweetPresenter.new(tweet, user)
    end
  end

  def tweet
    user.tweets.order(created_at: :desc)
  end

  def user
    @user ||= User.find(params[:id])
  end
end