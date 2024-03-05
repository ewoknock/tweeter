class AddUsernameAndDisplaynameToUsers < ActiveRecord::Migration[7.1]
  def up
    add_column :users, :username, :string
    add_index :users, :username, unique: true

    add_column :users, :display_name, :string
    query = <<~SQL
      update users
      set display_name = username
      where display_name is null
    SQL
    ActiveRecord::Base.connection.execute(query)
  end

  def down
    remove_column :users, [:username, :display_name]
  end
end
