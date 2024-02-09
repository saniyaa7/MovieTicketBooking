# frozen_string_literal: true

class Movie < ApplicationRecord
  validates :title, :stars, presence: true
  has_many :movie_shows
  before_validation :normalize

  private

  def normalize
    self.title = title.downcase.titleize
    self.stars = stars.downcase.titleize
    self.description = description.downcase.titleize if description.present?
  end
end
