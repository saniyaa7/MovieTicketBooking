# frozen_string_literal: true
module Api
  module V1
    
    class TicketsController < ApplicationController
      
      before_action :set_group, only: %i[show update destroy]
      # load_and_authorize_resource
      def index
        @tickets = Ticket.all
        authorize! :index, @ticket

        render json: @tickets
      end

      def show
        authorize! :show, @ticket
        render json: @ticket
      end

      def create
        # @ticket = Ticket.new(group_params)
        # binding.pry

        @ticket = current_user.tickets.new(group_params)
        authorize! :create, @ticket
        movie_show = MovieShow.find(@ticket.movie_show_id)
        
        if @ticket.calculate_and_save_price(movie_show) && @ticket.save
          debugger
          render json: @ticket, status: :created, location: api_v1_ticket_url(@ticket)
        else
          render json: @ticket.errors, status: :unprocessable_entity
        end
      end
      
      def update
        authorize! :update, @ticket
        if @ticket.update(group_params)
          render json: @ticket
        else
          render json: @ticket.errors, status: :unprocessable_entity
        end
      end

      def destroy
        authorize! :destroy, @ticket
      
        if @ticket.destroy
          render json: { data: 'Ticket deleted successfully', status: 'success' }
        else
          render json: { data: 'Something went wrong', status: 'failed' }
        end
      end
      
      private

      # Use callbacks to share common setup or constraints between actions.
      def set_group
        @ticket = Ticket.find_by(id: params[:id])
      
        unless @ticket
          render json: { data: 'Ticket not found', status: 'failed' }
        end
      end
      

      # Only allow a list of trusted parameters through.
      def group_params
        params.require(:ticket).permit(:payment_mode, :seat_book, :user_id, :movie_show_id,
                                    seat_type: [])
      end
    end
  end
end
