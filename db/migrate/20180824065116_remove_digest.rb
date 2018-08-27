class RemoveDigest < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :password_digest
    remove_column :users, :reset_digest
    remove_column :users, :activation_digest
  end
end
