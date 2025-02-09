# frozen_string_literal: true

class AddEmailInUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :email, :string
    add_index :users, :email, unique: true
    remove_column :users, :password_digest
  end
end
