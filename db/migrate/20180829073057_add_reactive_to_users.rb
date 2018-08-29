class AddReactiveToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :reactive_digest, :string
    add_column :users, :reactive_sent_at, :string
  end
end
