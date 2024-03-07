class AddRepliesCountToTweets < ActiveRecord::Migration[7.1]
  def up
    add_column :tweets, :replies_count, :integer, null: false, default: 0

    Tweet.find_each do |tweet|
      tweet.update! replies_count: tweet.replies.size
    end
  end

  def down
    remove_column :tweets, :replies_count
  end
end
