class CreateMovieShows < ActiveRecord::Migration[7.1]
  def change
    create_table :movie_shows do |t|
      t.string :language
      t.integer :seat_count
      t.time :show_start_time
      t.time :show_end_time
      t.integer :screen_no
      t.references :movie, foreign_key: true
      t.timestamps
    end
  end
end
