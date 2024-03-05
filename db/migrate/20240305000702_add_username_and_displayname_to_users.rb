class AddUsernameAndDisplaynameToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :username, :string
    add_index :users, :username, unique: true

    add_column :users, :display_name, :string
  end
end
