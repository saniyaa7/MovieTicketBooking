# frozen_string_literal: true

class Movie < ApplicationRecord
  validates :title, :stars,:user_id, presence: true, length: { maximum: 255 }
  validates :title, uniqueness: true
  before_validation :normalize
  belongs_to :user
  has_many :movie_shows

  private

  def normalize
    self.title = title.to_s.downcase.titleize
    self.stars = stars.to_s.downcase.titleize
    self.description = description.to_s.downcase.titleize if description.present?
  end
end
