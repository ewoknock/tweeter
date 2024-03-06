class TweetPresenter
  include ActionView::Helpers::DateHelper
  include Rails.application.routes.url_helpers

  attr_reader :tweet, :current_user, :source
  attr_reader :liked_tweet_path, :liked_tweet_turbo_data_method, :liked_tweet_image, :liked_tweet_class
  attr_reader :bookmarked_tweet_path, :bookmarked_tweet_turbo_data_method, :bookmarked_tweet_image, :bookmarked_tweet_class, :bookmarked_tweet_text

  delegate :user, :body, :likes, :likes_count, :liked_users, to: :tweet

  def initialize(tweet, current_user, source = "tweet_card")
    @tweet = tweet
    @current_user = current_user
    @source = source
    tweet_liked_by_current_user
    tweet_bookmarked_by_current_user
  end

  def created_at
    if (Time.zone.now - @tweet.created_at) > 1.day
      @tweet.created_at.strftime("%b %-d")
    else
      time_ago_in_words(@tweet.created_at)
    end
  end

  def tweet_liked_by_current_user
    if tweet.liked_users.include?(current_user)
      @liked_tweet_path = tweet_like_path(tweet, current_user.likes.find_by(tweet: tweet), source: @source)
      @liked_tweet_turbo_data_method = "delete"
      @liked_tweet_image = "red-heart-icon.svg"
      @liked_tweet_class = "action-element likes liked"
    else
      @liked_tweet_path = tweet_likes_path(tweet, source: @source)
      @liked_tweet_turbo_data_method = "post"
      @liked_tweet_image = "heart-outline.svg"
      @liked_tweet_class = "action-element likes"
    end
  end

  def tweet_bookmarked_by_current_user
    if tweet.bookmarked_users.include?(current_user)
      @bookmarked_tweet_path = tweet_bookmark_path(tweet, current_user.bookmarks.find_by(tweet: tweet), source: @source)
      @bookmarked_tweet_turbo_data_method = "delete"
      @bookmarked_tweet_image = "bookmark-filled.svg"
      @bookmarked_tweet_class = "action-element bookmarked"
      @bookmarked_tweet_text = "Bookmarked"
    else
      @bookmarked_tweet_path = tweet_bookmarks_path(tweet, source: @source)
      @bookmarked_tweet_turbo_data_method = "post"
      @bookmarked_tweet_image = "bookmark-outline.svg"
      @bookmarked_tweet_class = "action-element normal bookmarks"
      @bookmarked_tweet_text = "Bookmark"
    end
  end
end
