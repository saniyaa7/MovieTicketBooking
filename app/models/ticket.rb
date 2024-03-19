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
  validate :match_seat_book_with_seat_type, :check_show_not_started
  validate :match_seat_book_with_seat_type, :check_show_not_started
  before_validation :normalize

  def calculate_and_save_price(movie_show)
    return false unless valid?

    total_price = 0
    seat_no = []

    seat_type.each do |type|
      return false unless validate_seat_availability(type, movie_show)

      total_price += movie_show.seat_type_price[type]
      seat_no << "#{type}_#{movie_show.seat_type_count[type]}"
      movie_show.seat_type_count[type] -= 1
    end

    self.price = total_price
    self.seat_number = seat_no.reverse
    self.transaction_id = "#{user_id}_#{movie_show_id}_#{Time.now.strftime('%Y%m%d%H%M%S')}"
    movie_show.save
  end

  private

  def match_seat_book_with_seat_type
    errors.add(:base, 'Seat book must match with the number of seat') if seat_book != seat_type.length
  end

  def check_show_not_started
    errors.add(:base, 'Show Already Started') if movie_show.show_start_time <= DateTime.now
  end

  def validate_seat_availability(type, movie_show)
    if movie_show.seat_type_count[type].to_i.zero?
      errors.add(:base, "No more #{type.capitalize} seats available")
      return false
    elsif movie_show.seat_type_count[type] < seat_type.count(type)
      errors.add(:base,
                 "Not enough #{type.capitalize} seats available. You can book only #{movie_show.seat_type_count[type]} seats of #{type.capitalize}")
      return false
    end

    true
  end

  def normalize
    self.payment_mode = payment_mode.to_s.downcase.titleize

    self.seat_type = seat_type.map(&:downcase)
  end
end
