# frozen_string_literal: true
module Api
  module V1
    class MovieShowsController < ApplicationController
      before_action :set_group, only: %i[show update destroy]
      
      def index
        authorize! :index, MovieShow
        @movieshows = MovieShow.all
        render json: @movieshows
      end
      

      def show
        authorize! :show, @movieshow
        render json: @movieshow, serializer: MovieShowSerializer
      end

      def create
        @movieshow = MovieShow.new(group_params)
        authorize! :create, @movieshow
        
        if @movieshow.check_date && @movieshow.save
          render json: @movieshow, status: :created, location: api_v1_movie_show_url(@movieshow)
        else
          render json: @movieshow.errors, status: :unprocessable_entity
        end
      end
      

      def update
        authorize! :update, @movieshow
        if @movieshow.update(group_params)
          render json: @movieshow
        else
          render json: @movieshow.errors, status: :unprocessable_entity
        end
      end

      def destroy
        authorize! :destroy, @movieshow
        if @movieshow.destroy
          render json: { data: 'Movie Show deleted successfully', status: 'success' }
        else
          render json: { data: 'Something went wrong', status: 'failed' }
        end
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_group
        
        @movieshow = MovieShow.find(params[:id])

        unless @movieshow
          render json: { data: 'Movie Show not found', status: 'failed' }
        end
      end

      # Only allow a list of trusted parameters through.
      def group_params
        params.require(:movie_show).permit(:language, :seat_count, :show_start_time, :show_end_time, :screen_no,
                                          :movie_id, seat_type: {})
      end
    end
  end
end
