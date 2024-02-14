# spec/models/movie_show_spec.rb
require 'rails_helper'

RSpec.describe MovieShow, type: :model do
  context 'validations' do
    it 'is valid with valid attributes' do
      movie_show = build(:movie_show)
      expect(movie_show).to be_valid
    end

    it 'is not valid without a language' do
      movie_show = build(:movie_show, language: nil)
      expect(movie_show).to_not be_valid
    end

    it 'is not valid without a seat count' do
      movie_show = build(:movie_show, seat_count: nil)
      expect(movie_show).to_not be_valid

    end 
     it 'is not valid without a show start time' do
      # movie_show = build(:movie_show, show_start_time: DateTime.now())
      movie_show = build(:movie_show, show_start_time: nil)
      puts movie_show.attributes # Add this line to see the attributes in the console
      expect(movie_show).to_not be_valid
      # expect(movie_show).to_not be_valid
    end

    it 'is not valid without a show end time' do
      movie_show = build(:movie_show, show_end_time: nil)
      expect(movie_show).to_not be_valid
    end

    it 'is not valid without a screen number' do
      movie_show = build(:movie_show, screen_no: nil)
      expect(movie_show).to_not be_valid
    end

    it 'checks if show start time is earlier than the end time' do
      movie_show = build(:movie_show, show_start_time: DateTime.now, show_end_time: DateTime.now + 1.hour)
      expect(movie_show).to be_valid
    end

    # it 'checks if show end time is not earlier than the start time' do
    #   movie_show = build(:movie_show, show_start_time: DateTime.now, show_end_time: DateTime.now)
    #   expect(movie_show).to_not be_valid
    # end
    
    it 'checks if the show duration is at least 1 hour' do
      movie_show = build(:movie_show, show_start_time: DateTime.now, show_end_time: DateTime.now + 60.minutes)
      expect(movie_show).to be_valid
    end 
  end

  context 'before validation callbacks' do
    it 'normalizes the language' do
      movie_show = build(:movie_show, language: 'ENGLISH')
      movie_show.valid?
      expect(movie_show.language).to eq('English')
    end
  end
end
