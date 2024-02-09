# frozen_string_literal: true

class Ticket < ApplicationRecord
  validates :seat_no, :price, presence: true
  belongs_to :user
  belongs_to :movie_show
end
