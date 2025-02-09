# frozen_string_literal: true

class User < ApplicationRecord
  # Devise modules
  include Devise::JWT::RevocationStrategies::JTIMatcher
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :jwt_authenticatable, jwt_revocation_strategy: self

  # Other validations
  validates :name, :age, :phone_no, presence: true
  validates :email, presence: true, uniqueness: true
  validates :phone_no, length: { is: 10 }
  validates :phone_no, numericality: { only_integer: true }
  before_validation :normalize

  # Associations
  belongs_to :role
  has_many :movie_shows
  has_many :movies
  has_many :theaters
  has_many :tickets

  private

  def normalize
    self.name = name.to_s.downcase.titleize
  end
end
