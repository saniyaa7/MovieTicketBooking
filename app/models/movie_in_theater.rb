class MovieInTheater < ApplicationRecord
  has_many :movie_shows
  has_many :theaters  
end
