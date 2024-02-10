# frozen_string_literal: true

class TicketsController < ApplicationController
  before_action :set_group, only: %i[show update destroy]
  def index
    @tickets = Ticket.all

    render json: @tickets
  end

  def show
    render json: @ticket
  end

  def create
    @ticket = Ticket.new(group_params)
    movie_show = MovieShow.find(@ticket.movie_show_id)
    if @ticket.calculate_and_save_price(movie_show) && @ticket.save
      debugger
      render json: @ticket, status: :created, location: @ticket
    else
      render json: @ticket.errors, status: :unprocessable_entity
    end
  end
  
  def update
    if @ticket.update(group_params)
      render json: @ticket
    else
      render json: @ticket.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @ticket.destroy!
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_group
    @ticket = Ticket.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def group_params
    params.require(:ticket).permit(:payment_mode, :seat_book, :user_id, :movie_show_id,
                                seat_type: [])
  end
end
