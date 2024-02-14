# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  validates :name, :age, :phone_no, presence: true
  validates :phone_no, length: { is: 10 }
  validates :password_digest, presence: true, length: { minimum: 8 }
  validates :phone_no, numericality: {only_integer: true}
  before_validation :normalize
  belongs_to :role
  has_many :tickets

  private

  def normalize
    self.name = name.to_s.downcase.titleize
  end
end
