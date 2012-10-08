class AddNicknameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :surname, :string
    add_column :users, :patronimic, :string
    add_column :users, :group_id, :integer
  end
end
