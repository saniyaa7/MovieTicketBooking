# frozen_string_literal: true

class MovieShow < ApplicationRecord
  validates :language, :seat_count, :show_start_time, :show_end_time, :screen_no, presence: true
  before_validation :normalize
  has_many :tickets
  has_many :movie_in_theaters
  belongs_to :movie
  def check_date
    if show_start_time >= show_end_time
      errors.add(:base, 'The show start time must be earlier than the end time.')
      return false
    end
    if (show_end_time - show_start_time) < 1
      errors.add(:base, 'The show must not be 1 hour ')
      return false
    end
    true
  end

  private

  def normalize
    self.language = language.to_s.downcase.titleize
  end
  
end
