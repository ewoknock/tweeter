class AddParentTweetIdToTweet < ActiveRecord::Migration[7.1]
  def change
    add_reference :tweets, :parent_tweet, foreign_key: { to_table: :tweets, column: :parent_tweet_id }

  end
end
