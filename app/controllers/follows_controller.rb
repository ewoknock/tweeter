class FollowsController < ApplicationController
  before_action :authenticate_user!

  def create
    follow = user.follows.create(follow_params)
    respond_to do |format|
      format.html { redirect_to user_path(User.find(follow.following_user_id))}
      format.turbo_stream
    end
    
  end

  def destroy
    user
    follow = Follow.find(params[:id])
    follow.destroy
    respond_to do |format|
      format.html { redirect_to user_path(user) }
      format.turbo_stream
    end
    
  end

  private

  def user
    @user ||= User.find(params[:user_id])
  end

  def follow_params
    params.permit(:following_user_id, :user_id)
  end
end