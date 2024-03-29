class RemoveColumnInTicket < ActiveRecord::Migration[7.1]
  def change
    remove_column :tickets, :seat_book
  end
end
