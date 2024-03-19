class ModalController < ApplicationController
  before_action :authenticate_user!
  
  def tweet_form
  end

  def profile_form

  end
end