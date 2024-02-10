# frozen_string_literal: true

class MovieShowSerializer < ActiveModel::Serializer
  attributes :id, :language, :seat_count, :show_start_time, :show_end_time, :screen_no, :seat_type
end
