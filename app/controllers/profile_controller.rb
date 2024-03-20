class ProfileController < ApplicationController
  before_action :authenticate_user!

  def show
    @tweets = tweet.map do |tweet|
      TweetPresenter.new(tweet, current_user)
    end
    @posts_active = "active"
    @msg = "#{@tweets.size} posts"
    #get_tweets(params[:source])
    respond_to do |format|
      format.html
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace("profile-tweets", partial: "profile_nav", local: {tweets: @tweets}),
          turbo_stream.replace("profile-tweet-count", partial: "shared/profile_tweet_count", locals: {user: current_user, msg: @msg })]
      end
    end
  end

  def likes
    @tweets = current_user.liked_tweets.order(created_at: :desc).map do |tweet|
      TweetPresenter.new(tweet, current_user)
    end
    @likes_active = "active"
    @msg = "#{@tweets.size} likes"
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
            turbo_stream.replace("profile-tweets", partial: "profile_nav", local: {tweets: @tweets}),
            turbo_stream.replace("profile-tweet-count", partial: "shared/profile_tweet_count", locals: {user: current_user, msg: @msg })]
      end
    end
  end

  def replies
    @tweets = user_replies
    @replies_active = "active"
    @msg = "#{@tweets.size} posts"
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace("profile-tweets", partial: "profile_nav", local: {tweets: @tweets}),
          turbo_stream.replace("profile-tweet-count", partial: "shared/profile_tweet_count", locals: {user: current_user, msg: @msg })]
      end
    end
  end

  def update
    current_user.update(profile_params[:password].blank? ? profile_params.except(:password) : profile_params)
    respond_to do |format|
      format.html { redirect_to profile_path }
      format.turbo_stream
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
      TweetPresenter.new(tweet, current_user)
    end
  end

  def user_likes
    current_user.liked_tweets.order(created_at: :desc).map do |tweet|
      TweetPresenter.new(tweet, current_user)
    end
  end

  def tweet
    current_user.tweets.order(created_at: :desc)
  end

  def profile_params
    params.require(:user).permit(:username, :display_name, :email, :password, :bio, :location, :url, :avatar)
  end
end