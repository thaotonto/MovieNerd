class RemoveBlockedFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :blocked
  end
end
