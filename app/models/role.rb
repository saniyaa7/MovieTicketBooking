# frozen_string_literal: true

class Role < ApplicationRecord
  has_one :user
end
