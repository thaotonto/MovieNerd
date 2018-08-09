class ChangeSeatsIndex < ActiveRecord::Migration[5.2]
  def change
    remove_index :seats, name: "index_seats_on_row_and_number"
    add_index :seats, [:room_id, :row, :number], unique: true
  end
end
