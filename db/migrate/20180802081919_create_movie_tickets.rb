class CreateMovieTickets < ActiveRecord::Migration[5.2]
  def change
    create_table :movie_tickets do |t|
      t.references :seat, foreign_key: true
      t.references :order, foreign_key: true

      t.timestamps
    end
  end
end
