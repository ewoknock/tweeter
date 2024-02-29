class CreateLikes < ActiveRecord::Migration[7.1]
  def change
    create_table :likes do |t|
      t.references :user, null: false, foreign_key: { to_table: :users }
      t.references :tweet, null: false, foreign_key: { to_table: :tweets }

      t.timestamps
    end
  end
end
