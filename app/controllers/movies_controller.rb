# frozen_string_literal: true

class MoviesController < ApplicationController
  before_action :set_group, only: %i[show update destroy]

  def index
    @movies = Movie.all
    render json: @movies, each_serializer: MovieSerializer
  end

  def show
    render json: @movie, serializer: MovieSerializer
  end

  def create
    @movie = Movie.new(group_params)

    if @movie.save
      render json: @movie, status: :created, location: @movie
    else
      render json: @movie.errors, status: :unprocessable_entity
    end
  end

  def update
    if @movie.update(group_params)
      render json: @movie
    else
      render json: @movie.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @movie.destroy!
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_group
    @movie = Movie.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def group_params
    params.require(:movie).permit(:title, :stars, :description)
  end
end
