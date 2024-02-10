class AddColumnInMovieShow < ActiveRecord::Migration[7.1]
  def change
    remove_column :movie_shows, :end_end_time, :time
    add_column :movie_shows, :show_end_time, :datetime
    add_column :movie_shows, :seat_type, :jsonb, default: {}
  end
end
