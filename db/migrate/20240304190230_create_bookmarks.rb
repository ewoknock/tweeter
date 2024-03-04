class CreateBookmarks < ActiveRecord::Migration[7.1]
  def change
    create_table :bookmarks do |t|
      t.references :user, null: false, foreign_key: { to_table: :users}
      t.references :tweet, null: false, foreign_key: { to_table: :tweets}

      t.index [:user_id, :tweet_id], unique: true

      t.timestamps
    end
  end
end
