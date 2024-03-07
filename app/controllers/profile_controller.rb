class ProfileController < ApplicationController
  before_action :authenticate_user!

  def show
    @tweets = current_user.tweets
  end
end