class TweetsController < ApplicationController
  before_action :authenticate_user!

  def show
    @tweet = Tweet.find(params[:id])
    @tweet_presenter = TweetPresenter.new(@tweet, current_user, "tweet_actions")
    @replies = @tweet.replies.order(created_at: :desc).map do |replies|
      TweetPresenter.new(replies, current_user)
    end
  end
  
  def create
    @tweet = Tweet.new(tweet_params.merge(user: current_user))

    if @tweet.save
      respond_to do |format|
        format.html { redirect_to dashboard_path, notice: "Tweet was successfully created." }
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def tweet_params
    params.require(:tweet).permit(:body)
  end
end