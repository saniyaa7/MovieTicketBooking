class User < ApplicationRecord
  has_secure_password

  validates :name, uniqueness: true
  validates :name, :age, :phone_no, presence: true
  validates :phone_no, length: { is: 10}
  validates :phone_no, numericality: true
  before_validation :normalize
  belongs_to :role
  has_many :tickets

  private
  
  def normalize
      self.name = name.downcase.titleize
      
  end
end
