require 'rails_helper'

RSpec.describe Movie, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  context 'validations' do
    it 'is valid with valid attributes' do
      movie = build(:movie)
      expect(movie).to be_valid
    end

    it 'is not valid without a title' do
      movie = build(:movie, title: nil)
      expect(movie).to_not be_valid
    end

    it 'is not valid without stars' do
      movie = build(:movie, stars: nil)
      expect(movie).to_not be_valid
    end
  end

  context 'before validation callbacks' do
    it 'normalizes title, stars, and description' do
      movie = build(:movie, title: 'the great movie', stars: 'john doe', description: 'a fantastic film')
      movie.valid?
      expect(movie.title).to eq('The Great Movie')
      expect(movie.stars).to eq('John Doe')
      expect(movie.description).to eq('A Fantastic Film')
    end

    it 'normalizes title and stars even if description is not present' do
      movie = build(:movie, title: 'the great movie', stars: 'john doe', description: nil)
      movie.valid?
      expect(movie.title).to eq('The Great Movie')
      expect(movie.stars).to eq('John Doe')
      expect(movie.description).to be_nil
    end
  end
end
