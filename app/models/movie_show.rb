# frozen_string_literal: true

class MovieShow < ApplicationRecord
  validates :language, :seat_count, :show_start_time, :show_end_time, :screen_no, presence: true
  before_validation :normalize
  has_many :tickets
  has_many :movie_in_theaters
  belongs_to :movie

  private

  def normalize
    self.language = language.downcase.titleize
  end
end
