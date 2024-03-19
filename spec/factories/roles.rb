# frozen_string_literal: true

FactoryBot.define do
  factory :role do
    # sequence(:id) { |n| n }
    role_name { 'admin' }
  end
end
