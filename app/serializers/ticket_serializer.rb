# frozen_string_literal: true

class TicketSerializer < ActiveModel::Serializer
  attributes :id, :price, :transaction_id, :payment_mode, :seat_book, :seat_no, :seat_type, :screen_number

  def screen_number
    object.movie_show.screen_no
  end
end
