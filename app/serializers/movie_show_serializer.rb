# frozen_string_literal: true

module Api
  module V1
    class MovieShowSerializer < ActiveModel::Serializer
      attributes :id, :language, :seat_count, :show_start_time, :show_end_time, :screen_no, :seat_type_price,
                 :seat_type_count
    end
  end
end
