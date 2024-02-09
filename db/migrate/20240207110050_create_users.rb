class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name
      t.integer :age
      t.string :phone_no
      t.string :password_digest
      t.references :role, foreign_key: true
      t.timestamps
    end
  end
end 


