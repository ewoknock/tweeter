class UsernamesController < ApplicationController
  before_action :authenticate_user!

  def new
    
  end

  def update
    if username_params[:username].present? && current_user.update(username_params)
      redirect_to dashboard_path
    else
      redirect_to new_username_path
    end
  end

  private

  def username_params
    params.require(:user).permit(:username, :display_name)
  end
end