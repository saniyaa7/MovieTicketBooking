# frozen_string_literal: true

class AddAndRenameColumnInMovieShow < ActiveRecord::Migration[7.1]
  def change
    add_column :movie_shows, :seat_type_count, :jsonb, default: {}
    rename_column :movie_shows, :seat_type, :seat_type_price
  end
end
