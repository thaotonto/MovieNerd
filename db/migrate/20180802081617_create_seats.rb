class CreateSeats < ActiveRecord::Migration[5.2]
  def change
    create_table :seats do |t|
      t.integer :row
      t.integer :number
      t.integer :seat_type
      t.references :room, foreign_key: true

      t.timestamps
    end

    add_index :seats, [:row, :number], unique: true
  end
end
