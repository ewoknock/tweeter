class TweetPresenter
  include ActionView::Helpers::DateHelper
  include Rails.application.routes.url_helpers

  attr_reader :tweet, :current_user

  delegate :user, :body, :likes, :likes_count, :liked_users, to: :tweet

  def initialize(tweet, current_user)
    @tweet = tweet
    @current_user = current_user
  end

  def created_at
    if (Time.zone.now - @tweet.created_at) > 1.day
      @tweet.created_at.strftime("%b %-d")
    else
      time_ago_in_words(@tweet.created_at)
    end
  end

  def liked_tweet_path
    if tweet_liked_by_current_user?
      tweet_like_path(tweet, current_user.likes.find_by(tweet: tweet))
    else
      tweet_likes_path(tweet)
    end
  end

  def liked_tweet_turbo_data_method
    if tweet_liked_by_current_user?
      "delete"
    else
      "post"
    end
  end

  def liked_tweet_image
    if tweet_liked_by_current_user?
      "red-heart-icon.svg"
    else
      "heart-outline.svg"
    end
  end

  def liked_tweet_class
    if tweet_liked_by_current_user?
      "action-element likes liked"
    else
      "action-element"
    end
  end

  def tweet_liked_by_current_user?
    @tweet_liked_by_current_user ||= tweet.liked_users.include?(current_user)
  end

  def bookmarked_tweet_path
    if tweet_bookmarked_by_current_user?
      tweet_bookmark_path(tweet, current_user.bookmarks.find_by(tweet: tweet))
    else
      tweet_bookmarks_path(tweet)
    end
  end

  def bookmarked_tweet_turbo_data_method
    if tweet_bookmarked_by_current_user?
      "delete"
    else
      "post"
    end
  end

  def bookmarked_tweet_image
    if tweet_bookmarked_by_current_user?
      "bookmark-filled.svg"
    else
      "bookmark-outline.svg"
    end
  end

  def bookmarked_tweet_class
    if tweet_bookmarked_by_current_user?
      "action-element bookmarks bookmarked"
    else
      "action-element normal"
    end
  end

  def bookmarked_tweet_text
    if tweet_bookmarked_by_current_user?
      "Bookmarked"
    else
      "Bookmark"
    end
  end

  def tweet_bookmarked_by_current_user?
    @tweet_bookmarked_by_current_user ||= tweet.bookmarked_users.include?(current_user)
  end
end
