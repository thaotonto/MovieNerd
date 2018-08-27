class RemoveUnuseField < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :remember_digest
    remove_column :users, :activated_at
    remove_column :users, :reset_sent_at
    remove_column :users, :activated
  end
end
