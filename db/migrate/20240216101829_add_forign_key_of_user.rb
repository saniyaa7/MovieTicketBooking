# frozen_string_literal: true

class AddForignKeyOfUser < ActiveRecord::Migration[7.1]
  def change
    add_reference :movie_shows, :user, foreign_key: true
    add_reference :movies, :user, foreign_key: true
    add_reference :theaters, :user, foreign_key: true
  end
end
