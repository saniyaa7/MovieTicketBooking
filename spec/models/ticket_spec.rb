# spec/models/ticket_spec.rb
require 'rails_helper'

RSpec.describe Ticket, type: :model do
  context 'Create User' do
    let!(:ticket) { create(:ticket) }

    it 'should be valid user with all attributes' do
      
      expect(ticket.valid?).to eq(true)
    end
  end

  context 'validations' do
    it 'is not valid without a payment mode' do
      ticket = build(:ticket, payment_mode: nil)
      expect(ticket).to_not be_valid
    end

    it 'is not valid without a seat book' do
      ticket = build(:ticket, seat_book: nil)
      expect(ticket).to_not be_valid
    end

    it 'is not valid without a user id' do
      ticket = build(:ticket, user_id: nil)
      expect(ticket).to_not be_valid
    end

    it 'is not valid without a movie_show_id' do
      ticket = build(:ticket, movie_show_id: nil)
    
      expect(ticket).to_not be_valid
    end

    # it 'is not valid without a seat type' do
      
    #   ticket = build(:ticket, seat_type: nil)
    #   debugger
    #   expect(ticket).to_not be_valid
      
    # end



    # it 'should validate inclusion of payment_mode in Online and Cash' do
    #   should validate_inclusion_of(:payment_mode).in_array(['Online', 'Cash'])
    # end
    # it 'should validate inclusion of payment_mode in Online and Cash' do
    #   should validate_inclusion_of(:payment_mode).in_array(['Online', 'Cash'])
    # end
    

    # it 'should validate inclusion of seat_type in standard, premium, vip when it is an array' do
    #   should validate_inclusion_of(:seat_type)
    #     .in_array(['standard', 'premium', 'vip'])
    #     .allow_nil
    #     .allow_blank
    # end

    describe Ticket do
      let(:user) { create(:user) }
      let(:movie_show) { create(:movie_show) }
      
      it 'should validate inclusion of seat_type in standard, premium, vip when it is an array' do
        ticket = build(:ticket, user: user, movie_show: movie_show, payment_mode: 'Online', seat_type: ['Standard'])
        
        expect(ticket).to be_valid

      end

      it 'should validate inclusion of payment_mode in Online and Cash' do
        ticket = build(:ticket, user: user, movie_show: movie_show, payment_mode: 'Cash', seat_type: ['Standard'])
        expect(ticket).to be_valid

      end

    end
    

  end
  # context 'with valid parameters' do
  #   it 'calculates and saves the price' do
  #     ticket.calculate_and_save_price(movie_show)
  #     expect(ticket.errors.empty?).to eq(true)
  #     expect(ticket.price).to be > 0
  #     expect(ticket.seat_no.length).to eq(ticket.seat_book)
  #     expect(movie_show.seat_count).to eq(10 - ticket.seat_book)
  #   end
  # end

  describe '#calculate_and_save_price' do
    let(:user) { create(:user) }
    let(:movie_show) do
      create(:movie_show, language: "English", seat_count: 10, show_start_time: DateTime.now + 1.hour, show_end_time: DateTime.now + 2.hours, screen_no: 2,
                          seat_type: { 'standard' => 10, 'premium' => 15, 'vip' => 20 })
    end
    let(:ticket) { build(:ticket, user: user, movie_show: movie_show, seat_book: 3, seat_type: %w[standard premium vip]) }

    context 'with valid parameters' do
      it 'calculates and saves the price' do
        expect(ticket.calculate_and_save_price(movie_show)).to be_truthy
        expect(ticket.errors).to be_empty
        expect(ticket.price).to be > 0
        expect(ticket.seat_no.length).to eq(ticket.seat_book)
        expect(movie_show.seat_count).to eq(10 - ticket.seat_book)
      end
    end

    context 'when seat book does not match with the number of seats' do
      it 'does not calculate and save price' do
        ticket.seat_book = 5
        expect(ticket.calculate_and_save_price(movie_show)).to be_falsey
        expect(ticket.errors.full_messages).to include('Seat book must match with the number of seat')
      end
    end

    context 'when show has already started' do
      it 'does not calculate and save price' do
        movie_show.update(show_start_time: DateTime.now - 1.hour)
        expect(ticket.calculate_and_save_price(movie_show)).to be_falsey
        expect(ticket.errors.full_messages).to include('Show Already Started')
      end
    end

    context 'when all seats are full' do
      it 'does not calculate and save price' do
        movie_show.update(seat_count: 0)
        expect(ticket.calculate_and_save_price(movie_show)).to be_falsey
        expect(ticket.errors.full_messages).to include('All seats are full')
      end
    end

    context 'when not enough seats are available' do
      it 'does not calculate and save price' do
        movie_show.update(seat_count: 2)
        ticket.seat_type = ['standard', 'premium', 'vip']
        expect(ticket.calculate_and_save_price(movie_show)).to be_falsey
        expect(ticket.errors.full_messages).to include('2 seats are available')
      end
    end
  end
end
