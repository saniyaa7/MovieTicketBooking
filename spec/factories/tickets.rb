# frozen_string_literal: true

# spec/factories/tickets.rb
FactoryBot.define do
  factory :ticket do
    payment_mode { %w[Online Cash].sample || 'Online' }
    seat_book { Faker::Number.number(digits: 1) }
    association :user, factory: :user
    association :movie_show, factory: :movie_show
    # seat_type { %w[standard premium vip].sample(Faker::Number.number(digits: 1).to_i) }
    seat_type { %w[standard premium vip].sample(Faker::Number.between(from: 1, to: 3)) }
  end
end
