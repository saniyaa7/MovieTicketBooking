class AddCoulmnInTicket < ActiveRecord::Migration[7.1]
  def change
    remove_column :movie_shows, :seat_type
    add_column :tickets, :seat_type, :jsonb, default: {}

    
  end
end
