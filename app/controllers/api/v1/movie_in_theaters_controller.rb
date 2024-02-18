# frozen_string_literal: true

module Api
  module V1
    class MovieInTheatersController < ApplicationController
      before_action :set_movie_in_theater, only: %i[show update destroy]

      def index
        authorize! :index, MovieInTheater
        @movie_in_theaters = MovieInTheater.all
        render json: @movie_in_theaters
      end

      def show
        authorize! :show, @movie_in_theater
        render json: @movie_in_theater
      end

      def create
        @movie_in_theater = MovieInTheater.new(movie_in_theater_params)
        authorize! :create, @movie_in_theater
        if @movie_in_theater.save
          render json: @movie_in_theater, status: :created, location: api_v1_movie_in_theater(@movie_in_theater)
        else
          render json: @movie_in_theater.errors, status: :unprocessable_entity
        end
      end

      def update
        authorize! :update, @movie_in_theater
        if @movie_in_theater.update(movie_in_theater_params)
          render json: @movie_in_theater
        else
          render json: @movie_in_theater.errors, status: :unprocessable_entity
        end
      end

      def destroy
        authorize! :destroy, @movie_in_theater
        if @movie_in_theater.destroy
          render json: { data: 'Record deleted successfully', status: 'success' }
        else
          render json: { data: 'Something went wrong', status: 'failed' }
        end
      end

      private

      def set_movie_in_theater
        @movie_in_theater = MovieInTheater.find(params[:id])
        return if @movie_in_theater
        render json: { data: 'Record not found', status: 'failed' }
      end

      def movie_in_theater_params
        params.require(:movie_in_theater).permit(:movie_show_id, :theater_id)
      end
    end
  end
end
