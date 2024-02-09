# frozen_string_literal: true

class AddColumnToTicket < ActiveRecord::Migration[7.1]
  def change
    add_column :tickets, :seat_no, :integer, array: true
  end
end
