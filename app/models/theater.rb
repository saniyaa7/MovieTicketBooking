class Theater < ApplicationRecord
  validates :name, presence: true
  before_validation :normalize
  belongs_to :movie_in_theater
  private

  def normalize
      self.name = name.downcase.titleize
      self.location= location.downcase.titleize if location.present?
      self.city= city.downcase.titleize if city.present?
  end
end
