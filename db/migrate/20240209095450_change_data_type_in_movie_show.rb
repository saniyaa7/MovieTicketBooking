# frozen_string_literal: true

class ChangeDataTypeInMovieShow < ActiveRecord::Migration[7.1]
  def change
    # add_column :movie_shows, :show_start_time, :datetime
    remove_column :movie_shows, :show_end_time, :time
    # add_column :movie_shows, :seat_type, :jsonb, default: {}
  end
end
