# frozen_string_literal: true

module Api
  module V1
    class MoviesController < ApplicationController
      before_action :set_movie, only: %i[show update destroy]

      def index
        authorize! :index, @movie
        @movies = Movie.all
        render json: @movies, each_serializer: MovieSerializer
      end

      def show
        authorize! :show, @movie
        render json: @movie, serializer: MovieSerializer
      end

      def create
        @movie = Movie.new(movie_params)
        authorize! :create, @movie
        # Assuming you want to associate the movie with the current user for reference
        if @movie.save
          render json: @movie, status: :created, location: api_v1_movie_url(@movie)
        else
          render json: @movie.errors, status: :unprocessable_entity
        end
      end

      def update
        authorize! :update, @movie
        if @movie.update(movie_params)
          render json: @movie
        else
          render json: @movie.errors, status: :unprocessable_entity
        end
      end

      def destroy
        authorize! :destroy, @movie
        if @movie.destroy
          render json: { data: 'Movie deleted successfully', status: 'success' }
        else
          render json: { data: 'Something went wrong', status: 'failed' }
        end
      end

      private

      def set_movie
        @movie = Movie.find_by(id: params[:id])
        return if @movie
        render json: { data: 'Movie not found', status: 'failed' }
      end

      def movie_params
        params.require(:movie).permit(:title, :stars, :description)
      end
    end
  end
end
