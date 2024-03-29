# frozen_string_literal: true

class TicketSerializer < ActiveModel::Serializer
  attributes :id, :price, :transaction_id, :payment_mode,  :seat_number, :seat_type, :screen_number,:movie_show_id,:movie_name

  def screen_number
    object.movie_show.screen_no
  end

  def movie_show_id
    object.movie_show.id
  end

  def movie_name
    object.movie_show.movie.title
  end
end
