class AddNewBlockedToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :blocked, :integer, default: 1
  end
end
