# frozen_string_literal: true

module Api
  module V1
    class MovieShowsController < ApplicationController
      before_action :set_movie_show, only: %i[show update destroy]

      def index
        authorize! :index, MovieShow
        @movieshows = MovieShow.all
        render json: @movieshows
      end

      def show
        authorize! :show, @movieshow
        render json: @movieshow
      end

      def create
        @movieshow = MovieShow.new(movie_show_params)
        authorize! :create, @movieshow

        if @movieshow.check_date && @movieshow.save
          render json: @movieshow, status: :created, location: api_v1_movie_show_url(@movieshow)
        else
          render json: @movieshow.errors, status: :unprocessable_entity
        end
      end

      def update
        authorize! :update, @movieshow
        if @movieshow.update(movie_show_params)
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

      def get_movie_show_by_theater_id
        theater =   Theater.find(params[:theater_id])
        @movieshows = theater.movie_shows
        render json: @movieshows
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_movie_show
        @movieshow = MovieShow.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { data: 'Movie Show not found', status: 'failed' }, status: :not_found
      end

      # Only allow a list of trusted parameters through.
      def movie_show_params
        params.require(:movie_show).permit(:user_id, :language, :seat_count, :show_start_time, :show_end_time, :screen_no,
                                           :movie_id, seat_type_count: {}, seat_type_price: {})
      end
    end
  end
end
