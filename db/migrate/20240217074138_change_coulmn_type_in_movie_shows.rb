# frozen_string_literal: true

class ChangeCoulmnTypeInMovieShows < ActiveRecord::Migration[7.1]
  def change
    # change_column :tickets, :seat_no, :string, array: true
    remove_column :tickets, :seat_no, :string
    add_column :tickets, :seat_number, :string, array: true
  end
end
