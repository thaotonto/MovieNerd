class CreateScreenings < ActiveRecord::Migration[5.2]
  def change
    create_table :screenings do |t|
      t.references :movie, foreign_key: true
      t.references :room, foreign_key: true
      t.datetime :screening_start

      t.timestamps
    end
  end
end
