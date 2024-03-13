class FollowsController < ApplicationController
  before_action :authenticate_user!

  def create
    follow = user.follows.create(follow_params)
    redirect_to user_path(User.find(follow.following_user_id))
  end

  def destroy
    follow = Follow.find(params[:id])
    follow.destroy
    redirect_to user_path(User.find(follow.following_user_id))
  end

  private

  def user
    @user ||= User.find(params[:user_id])
  end

  def follow_params
    params.permit(:following_user_id)
  end
end