# frozen_string_literal: true

class Ticket < ApplicationRecord
  validates :seat_no, :price, presence: true
  belongs_to :user
  belongs_to :movie_show
  validates :payment_mode, inclusion: { in: %w(Online Cash),
  message: "%{value} is not a valid payment_mode" }
  before_validation :normalize
  private

  def normalize
    self.payment_mode = payment_mode.downcase.titleize
    
  end
  
end
