class RepliesController < ApplicationController
  before_action :authenticate_user!
 
  def create
    @tweet = tweet.replies.create(tweet_params.merge(user: current_user, parent_tweet_id: params[:tweet_id]))

    if @tweet.save
      respond_to do |format|
        format.html { redirect_to tweet_path(params[:tweet_id]), notice: "Tweet was successfully created." }
        format.turbo_stream
      end
    else
      render new:, status: :unprocessable_entity
    end
  end

  private

  def tweet
    @tweet ||= Tweet.find(params[:tweet_id])
  end

  def tweet_params
    params.require(:tweet).permit(:body)
  end
end