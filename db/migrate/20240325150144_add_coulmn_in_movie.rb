# frozen_string_literal: true

class AddCoulmnInMovie < ActiveRecord::Migration[7.1]
  def change
    add_column :movies, :img_url, :string
  end
end
