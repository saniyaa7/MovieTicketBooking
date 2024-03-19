# frozen_string_literal: true

class Theater < ApplicationRecord
  validates :name, presence: true
  before_validation :normalize
  has_many :movie_in_theaters
  belongs_to :user

  private

  def normalize
    self.name = name.downcase.titleize
    self.location = location.downcase.titleize if location.present?
    self.city = city.downcase.titleize if city.present?
  end
end
