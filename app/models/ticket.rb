# frozen_string_literal: true

class Ticket < ApplicationRecord
  validates :payment_mode, :seat_book, :user_id, :movie_show_id, :seat_type, presence: true
  belongs_to :user
  belongs_to :movie_show
  validates :payment_mode, inclusion: { in: %w[Online Cash],
                                        message: '%<value>s is not a valid payment_mode' }
  validates :seat_type, inclusion: { in: %w[standard premium vip],
                                     message: '%<value>s is not a valid seat_type' }, allow_blank: true, if: lambda {
                                                                                                               seat_type.present? && seat_type.is_a?(Array)
                                                                                                             }
  before_validation :normalize

  def calculate_and_save_price(movie_show)
    total_price = 0
    seat_no = []
    if seat_book != seat_type.length
      errors.add(:base, 'Seat book must match with the number of seat')
      return false
    end

    if movie_show.show_start_time <= DateTime.now
      errors.add(:base, 'Show Already Started')
      return false
    end

    if movie_show.seat_count.zero?
      errors.add(:base, 'All seats are full')
      return false
    end
    if movie_show.seat_count < seat_type.length
      errors.add(:base, "#{movie_show.seat_count} seats are available")
      return false
    end
    seat_type.each do |type|
      total_price += movie_show.seat_type[type]
      seat_no << movie_show.seat_count
      movie_show.seat_count -= 1
    end
    self.price = total_price
    self.seat_no = seat_no.reverse
    self.transaction_id = "#{user_id}_#{movie_show_id}_#{Time.now.strftime('%Y%m%d%H%M%S')}"
    movie_show.save
  end

  private

  def normalize
    self.payment_mode = payment_mode.to_s.downcase.titleize

    self.seat_type = seat_type.map(&:downcase)
  end
end
  