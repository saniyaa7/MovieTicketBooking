# frozen_string_literal: true

# spec/factories/theaters.rb
FactoryBot.define do
  factory :theater do
    name { Faker::Lorem.word }
    location { Faker::Address.city }
    city { Faker::Address.state }
  end
end
