# frozen_string_literal: true

class MovieInTheater < ApplicationRecord
  belongs_to :movie_show
  belongs_to :theater
end
