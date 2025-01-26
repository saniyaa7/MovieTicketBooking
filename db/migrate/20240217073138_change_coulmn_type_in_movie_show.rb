# frozen_string_literal: true

class ChangeCoulmnTypeInMovieShow < ActiveRecord::Migration[7.1]
  def change
    remove_column :tickets, :seat_no, :string
    add_column :tickets, :seat_number, :string, array: true
  end
end
