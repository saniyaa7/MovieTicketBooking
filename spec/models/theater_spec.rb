# frozen_string_literal: true

# spec/models/theater_spec.rb
require 'rails_helper'

RSpec.describe Theater, type: :model do
  context 'validations' do
    it 'is valid with valid attributes' do
      theater = build(:theater)
      expect(theater).to be_valid
    end
  end
  describe 'before_validation' do
    it 'normalizes name, location, and city' do
      theater = create(:theater, name: 'example theater', location: 'new york', city: 'ny')
      expect(theater.name).to eq('Example Theater')
      expect(theater.location).to eq('New York')
      expect(theater.city).to eq('Ny')
    end
  end
end
