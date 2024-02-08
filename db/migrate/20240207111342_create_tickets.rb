class CreateTickets < ActiveRecord::Migration[7.1]
  def change
    create_table :tickets do |t|
      t.integer :price
      t.string :transaction_id
      t.string :payment_mode
      t.integer :seat_book
      t.references :user, foreign_key: true
      t.references :movie, foreign_key: true
      t.timestamps
    end
  end
end
