class CreateMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :cast
      t.string :director
      t.text :description
      t.integer :duration
      t.integer :rated
      t.string :language
      t.string :genre
      t.date :release_date

      t.timestamps
    end

    add_index :movies, :title, unique: true
  end
end
