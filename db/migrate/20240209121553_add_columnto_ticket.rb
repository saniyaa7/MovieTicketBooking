# frozen_string_literal: true

class AddColumntoTicket < ActiveRecord::Migration[7.1]
  def change
    add_column :tickets, :seat_type, :string, array: true
  end
end
