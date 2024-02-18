# frozen_string_literal: true

class CreateMovieInTheaters < ActiveRecord::Migration[7.1]
  def change
    create_table :movie_in_theaters do |t|
      t.references :movie_show, foreign_key: true
      t.references :theater, foreign_key: true
      t.timestamps
    end
  end
end
